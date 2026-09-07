// import 'dart:async';
// import 'package:hekaya_resturant_market/core/entities/order_entity.dart';
// import '../../../../core/entities/selected_location_entity.dart';
// import '../../../../core/repos/order_repo/order_repo.dart';
// import '../../../../core/repos/upload_image_repo/upload_image_repo.dart';
// import '../../../../core/utils/app_imports.dart';
// import '../view/pages/address_page_view.dart';
// import '../view/pages/payment_method_view.dart';
// import '../view/pages/review_order_view.dart';
// import '../view/pages/select_location_view.dart';
// part 'checkout_state.dart';
//
// class CheckoutCubit extends Cubit<CheckoutState> {
//   CheckoutCubit(this.orderEntity, this._orderRepo, this._uploadImageRepo)
//     : super(CheckoutInitial());
//
//   final OrderRepo _orderRepo;
//   final UploadImageRepo _uploadImageRepo;
//   Timer? timer;
//   OrderEntity orderEntity;
//   final notesController = TextEditingController();
//   final PageController pageController = PageController();
//   int currentIndex = 0;
//   bool? isCashOnDelivery;
//   int? selectedLocationIndex;
//   final List<String> stepperTitles = ['الدفع', 'المكان', 'العنوان', 'مراجعه'];
//   final List<Widget> stepperPages = const [
//     PaymentMethodView(),
//     SelectLocationView(),
//     AddressPageView(),
//     ReviewOrderView(),
//   ];
//   late List<Map<String, String>> paymentOptions = [
//     {
//       "title": "الدفع عند الاستلام",
//       "subtitle": "التسليم الي المكان",
//       "price": "${orderEntity.cartEntity.getTotalPrice()} جنيه",
//     },
//     {
//       "title": "الدفع اونلاين",
//       "subtitle": "يرجي تحديد طريقه الدفع",
//       "price": "${orderEntity.cartEntity.getTotalPrice()} جنيه",
//     },
//   ];
//   // final List<SelectedLocationEntity> placesOptions = [
//   //   SelectedLocationEntity(
//   //     title: 'الاستلام من المطعم',
//   //     subTitle: 'استلم طلبك من المطعم',
//   //     cost: 0,
//   //   ),
//   //   SelectedLocationEntity(
//   //     title: 'كفر الشوربجي',
//   //     subTitle: 'اختر عنوانك داخل كفر الشوربجي',
//   //     cost: 10,
//   //   ),
//   //   SelectedLocationEntity(
//   //     title: 'ديما',
//   //     subTitle: 'اختر عنوانك داخل ديما',
//   //     cost: 10,
//   //   ),
//   //   SelectedLocationEntity(
//   //     title: 'كفر المنشي',
//   //     subTitle: 'اختر عنوانك داخل كفر المنشي',
//   //     cost: 20,
//   //   ),
//   //   SelectedLocationEntity(
//   //     title: 'كفر المنصوره',
//   //     subTitle: 'اختر عنوانك داخل كفر المنصوره',
//   //     cost: 20,
//   //   ),
//   //   SelectedLocationEntity(
//   //     title: 'شبرا',
//   //     subTitle: 'اختر عنوانك داخل شبرا',
//   //     cost: 20,
//   //   ),
//   //   SelectedLocationEntity(
//   //     title: 'برما',
//   //     subTitle: 'اختر عنوانك داخل برما',
//   //     cost: 25,
//   //   ),
//   // ];
//   void changePage(int index) {
//     currentIndex = index;
//     emit(CheckoutChangePage());
//     pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void changeSelectedLocationIndex(int index) {
//     selectedLocationIndex = index;
//     emit(CheckoutChangeLocationIndex());
//   }
//
//   void selectShipping(bool value) {
//     isCashOnDelivery = value;
//     emit(CheckoutSelectShipping());
//   }
//
//   Future<void> addOrder(OrderEntity orderEntity) async {
//     emit(CheckoutAddOrderLoading());
//
//     // الدفع عند الاستلام
//     if (orderEntity.isCashOnDelivery == true) {
//       orderEntity.paymentImage = null;
//
//       final result = await _orderRepo.addOrder(orderEntity);
//
//       result.fold(
//         (failure) {
//           emit(CheckoutAddOrderError(failure.errMessage));
//         },
//         (data) {
//           orderEntity.id = data;
//           emit(CheckoutAddOrderSuccess());
//         },
//       );
//
//       return;
//     }
//     if (orderEntity.paymentFileImage == null) {
//       emit(CheckoutAddOrderError('يرجى إرفاق صورة إثبات الدفع'));
//       return;
//     }
//
//     final imageResult = await _uploadImageRepo.uploadImage(
//       orderEntity.paymentFileImage!,
//     );
//
//     imageResult.fold(
//       (failure) {
//         emit(CheckoutAddOrderError(failure.errMessage));
//       },
//       (imageUrl) async {
//         orderEntity.paymentImage = imageUrl;
//
//         final result = await _orderRepo.addOrder(orderEntity);
//
//         result.fold(
//           (failure) {
//             emit(CheckoutAddOrderError(failure.errMessage));
//           },
//           (data) {
//             orderEntity.id = data;
//             emit(CheckoutAddOrderSuccess());
//           },
//         );
//       },
//     );
//   }
// }

import 'dart:async';
import '../../../../core/entities/order_entity.dart';
import '../../../../core/entities/selected_location_entity.dart';
import '../../../../core/repos/location_repo/selected_location_repo.dart';
import '../../../../core/repos/order_repo/order_repo.dart';
import '../../../../core/repos/upload_image_repo/upload_image_repo.dart';
import '../../../../core/utils/app_imports.dart';
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
      ) : super(CheckoutInitial()) {
    _listenToLocations();
  }

  final OrderRepo _orderRepo;
  final UploadImageRepo _uploadImageRepo;
  final SelectedLocationRepo _selectedLocationRepo;

  Timer? timer;

  OrderEntity orderEntity;

  final notesController = TextEditingController();
  final PageController pageController = PageController();

  int currentIndex = 0;

  bool? isCashOnDelivery;
  int? selectedLocationIndex;

  List<SelectedLocationEntity> placesOptions = [];

  StreamSubscription<List<SelectedLocationEntity>>? _locationsSubscription;

  final List<String> stepperTitles = [
    'الدفع',
    'المكان',
    'العنوان',
    'مراجعه',
  ];

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
      "price": "${orderEntity.cartEntity.getTotalPrice()} جنيه",
    },
    {
      "title": "الدفع اونلاين",
      "subtitle": "يرجي تحديد طريقه الدفع",
      "price": "${orderEntity.cartEntity.getTotalPrice()} جنيه",
    },
  ];

  void _listenToLocations() {
    emit(CheckoutLocationsLoading());

    _locationsSubscription = _selectedLocationRepo
        .getLocationsStream()
        .listen(
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
        emit(
          CheckoutLocationsError(
            error.toString(),
          ),
        );
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

  Future<void> addOrder(OrderEntity orderEntity) async {
    emit(CheckoutAddOrderLoading());

    // الدفع عند الاستلام
    if (orderEntity.isCashOnDelivery == true) {
      orderEntity.paymentImage = null;

      final result = await _orderRepo.addOrder(orderEntity);

      result.fold(
            (failure) {
          emit(
            CheckoutAddOrderError(
              failure.errMessage,
            ),
          );
        },
            (data) {
          orderEntity.id = data;

          emit(
            CheckoutAddOrderSuccess(),
          );
        },
      );

      return;
    }

    // الدفع أونلاين
    if (orderEntity.paymentFileImage == null) {
      emit(
        CheckoutAddOrderError(
          'يرجى إرفاق صورة إثبات الدفع',
        ),
      );

      return;
    }

    final imageResult = await _uploadImageRepo.uploadImage(
      orderEntity.paymentFileImage!,
    );

    imageResult.fold(
          (failure) {
        emit(
          CheckoutAddOrderError(
            failure.errMessage,
          ),
        );
      },
          (imageUrl) async {
        orderEntity.paymentImage = imageUrl;

        final result = await _orderRepo.addOrder(orderEntity);

        result.fold(
              (failure) {
            emit(
              CheckoutAddOrderError(
                failure.errMessage,
              ),
            );
          },
              (data) {
            orderEntity.id = data;

            emit(
              CheckoutAddOrderSuccess(),
            );
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