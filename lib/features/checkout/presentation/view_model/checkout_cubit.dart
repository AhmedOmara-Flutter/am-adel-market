import 'dart:async';
import '../../../../core/entities/order_entity.dart';
import '../../../../core/entities/selected_location_entity.dart';
import '../../../../core/helper_function/get_user.dart';
import '../../../../core/repos/location_repo/selected_location_repo.dart';
import '../../../../core/repos/order_repo/order_repo.dart';
import '../../../../core/repos/upload_image_repo/upload_image_repo.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../coupon/data/repos/coupon_repo.dart';
import '../../../coupon/domain/entities/coupon_entity.dart';
import '../view/pages/address_page_view.dart';
import '../view/pages/payment_method_view.dart';
import '../view/pages/review_order_view.dart';
import '../view/pages/select_location_view.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(
    this.orderEntity,
    this._orderRepo,
    this._uploadImageRepo,
    this._selectedLocationRepo,
    this._couponRepo,
  ) : super(CheckoutInitial()) {
    _listenToLocations();
  }

  final OrderRepo _orderRepo;
  final UploadImageRepo _uploadImageRepo;
  final SelectedLocationRepo _selectedLocationRepo;
  final CouponRepo _couponRepo;

  Timer? timer;

  OrderEntity orderEntity;

  final notesController = TextEditingController();
  final PageController pageController = PageController();

  int currentIndex = 0;
  bool? isCashOnDelivery;
  int? selectedLocationIndex;

  List<SelectedLocationEntity> placesOptions = [];

  StreamSubscription<List<SelectedLocationEntity>>? _locationsSubscription;

  final List<String> stepperTitles = ['الدفع', 'المكان', 'العنوان', 'مراجعه'];

  final List<Widget> stepperPages = const [
    PaymentMethodView(),
    SelectLocationView(),
    AddressPageView(),
    ReviewOrderView(),
  ];

  late List<Map<String, String>> paymentOptions = [
    {
      "title": "الدفع عند الاستلام",
      "subtitle": "التسليم الي المكان",
      "price":
          "${orderEntity.cartEntity.getTotalPrice().toStringAsFixed(2)} جنيه",
    },
    {
      "title": "الدفع اونلاين",
      "subtitle": "يرجي تحديد طريقه الدفع",
      "price":
          "${orderEntity.cartEntity.getTotalPrice().toStringAsFixed(2)} جنيه",
    },
  ];

  String enteredCouponCode = '';

  CouponEntity? appliedCoupon;

  double couponDiscount = 0;

  void removeCoupon() {
    appliedCoupon = null;
    couponDiscount = 0;
    enteredCouponCode = '';

    emit(CheckoutCouponRemoved());
  }

  Future<void> verifyCoupon(String code) async {
    if (code.trim().isEmpty) {
      emit(CheckoutCouponError('يرجى إدخال كود الكوبون'));
      return;
    }

    emit(CheckoutCouponLoading());

    final orderTotal = orderEntity.cartEntity.getTotalPrice().toDouble();

    debugPrint('COUPON ORDER TOTAL: $orderTotal');

    debugPrint('COUPON CODE: $code');

    final result = await _couponRepo.verifyCoupon(
      userId: getUser().uId,
      code: code,
      orderTotal: orderTotal,
    );

    result.fold(
      (failure) {
        appliedCoupon = null;
        couponDiscount = 0;

        print(failure.errMessage);

        emit(CheckoutCouponError(failure.errMessage));
      },
      (coupon) {
        appliedCoupon = coupon;

        enteredCouponCode = coupon.code;

        couponDiscount = _calculateCouponDiscount(
          coupon: coupon,
          orderTotal: orderTotal,
        );

        emit(CheckoutCouponSuccess());
      },
    );
  }

  double _calculateCouponDiscount({
    required CouponEntity coupon,
    required double orderTotal,
  }) {
    double discount;

    if (coupon.discountType == 'percentage') {
      discount = orderTotal * (coupon.discountValue / 100);
    } else {
      discount = coupon.discountValue;
    }

    if (coupon.maxDiscount > 0) {
      discount = discount > coupon.maxDiscount ? coupon.maxDiscount : discount;
    }

    if (discount > orderTotal) {
      discount = orderTotal;
    }

    return discount;
  }

  void _listenToLocations() {
    emit(CheckoutLocationsLoading());

    _locationsSubscription = _selectedLocationRepo.getLocationsStream().listen(
      (locations) {
        debugPrint('🔥 LOCATIONS RECEIVED: ${locations.length}');

        placesOptions = locations;

        if (selectedLocationIndex != null &&
            selectedLocationIndex! >= placesOptions.length) {
          selectedLocationIndex = null;
        }

        emit(CheckoutLocationsUpdated());
      },
      onError: (error) {
        emit(CheckoutLocationsError(error.toString()));
      },
    );
  }

  void changePage(int index) {
    currentIndex = index;

    emit(CheckoutChangePage());

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void changeSelectedLocationIndex(int index) {
    selectedLocationIndex = index;

    emit(CheckoutChangeLocationIndex());
  }

  void selectShipping(bool value) {
    isCashOnDelivery = value;

    emit(CheckoutSelectShipping());
  }

  Future<void> _markAppliedCouponAsUsed() async {
    if (appliedCoupon == null) {
      return;
    }

    final result = await _couponRepo.markCouponAsUsed(
      userId: getUser().uId,
      couponId: appliedCoupon!.id,
    );

    result.fold(
      (failure) {
        debugPrint(
          '❌ Failed to mark coupon as used: '
          '${failure.errMessage}',
        );
      },
      (_) {
        debugPrint('✅ Coupon marked as used: ${appliedCoupon!.code}');
      },
    );
  }

  Future<void> addOrder(OrderEntity orderEntity) async {
    emit(CheckoutAddOrderLoading());

    final subtotal = orderEntity.cartEntity.getTotalPrice().toDouble();

    final deliveryCost =
        orderEntity.selectedLocationEntity?.cost.toDouble() ?? 0;

    final finalTotal = subtotal + deliveryCost - couponDiscount;

    orderEntity.totalPrice = finalTotal;

    orderEntity.couponDiscount = couponDiscount;

    debugPrint('SUBTOTAL: $subtotal');

    debugPrint('DELIVERY: $deliveryCost');

    debugPrint('DISCOUNT: $couponDiscount');

    debugPrint('FINAL TOTAL: $finalTotal');

    // الدفع عند الاستلام
    if (orderEntity.isCashOnDelivery == true) {
      orderEntity.paymentImage = null;

      final result = await _orderRepo.addOrder(orderEntity);

      await result.fold(
        (failure) async {
          emit(CheckoutAddOrderError(failure.errMessage));
        },
        (data) async {
          orderEntity.id = data;

          await _markAppliedCouponAsUsed();

          emit(CheckoutAddOrderSuccess());
        },
      );

      return;
    }

    // الدفع أونلاين
    if (orderEntity.paymentFileImage == null) {
      emit(CheckoutAddOrderError('يرجى إرفاق صورة إثبات الدفع'));

      return;
    }

    final imageResult = await _uploadImageRepo.uploadImage(
      orderEntity.paymentFileImage!,
    );

    await imageResult.fold(
      (failure) async {
        emit(CheckoutAddOrderError(failure.errMessage));
      },
      (imageUrl) async {
        orderEntity.paymentImage = imageUrl;

        final result = await _orderRepo.addOrder(orderEntity);

        await result.fold(
          (failure) async {
            emit(CheckoutAddOrderError(failure.errMessage));
          },
          (data) async {
            orderEntity.id = data;

            await _markAppliedCouponAsUsed();

            emit(CheckoutAddOrderSuccess());
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _locationsSubscription?.cancel();

    notesController.dispose();
    pageController.dispose();

    timer?.cancel();

    return super.close();
  }
}
