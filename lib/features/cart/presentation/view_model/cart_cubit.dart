import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/entities/bundle_offer_entity.dart';
import '../../../../core/entities/offer_entity.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/helper_function/price_helper.dart';
import '../../../../core/repos/cart_repo/cart_repo.dart';
import '../../../offers/presentation/view_model/offer_cubit.dart';
import '../../domain/entities/bundle_offer_cart_item_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());

  final CartRepo cartRepo;

  CartEntity cart = CartEntity(cartItems: []);
  Timer? _saveTimer;
  StreamSubscription<CartEntity>? _cartSubscription;


  Future<void> loadCart(String userId) async {
    await _cartSubscription?.cancel();

    _cartSubscription = cartRepo.cartStream(userId).listen(
          (cartEntity) {
        cart = cartEntity;
        emit(CartLoaded());
      },
      onError: (e) {
        print('Cart Stream Error: $e');
      },
      onDone: () {
        print('Cart stream closed');
      },
    );
  }

  void _scheduleSave(String userId) {
    _saveTimer?.cancel();

    _saveTimer = Timer(
      const Duration(milliseconds: 500),
          () async {
        try {
          await cartRepo.saveCart(
            userId: userId,
            cart: cart,
          );
        } catch (e) {
          print(e);
        }
      },
    );
  }

  Future<void> addProduct(
      ProductEntity product,
      OfferEntity? offer,
      String userId,
      ) async
  {
    final price = getFinalPrice(
      product: product,
      offer: offer,
    );

    bool isExist = cart.isExist(product);

    if (isExist) {
      for (var element in cart.cartItems) {
        if (element.product.code == product.code) {
          element.quantity++;
          break;
        }
      }
    } else {
      cart = cart.addItem(
        CartItemEntity(
          product: product,
          unitPrice: price,
          quantity: 1,
        ),
      );
    }
    emit(CartAdded());

    _scheduleSave(userId);
  }

  Future<void> deleteCartItem(
      CartItemEntity cartItem,
      String userId,
      ) async
  {
    cart = cart.removeItem(cartItem);
    emit(CartRemoved());

    _scheduleSave(userId);
  }

  Future<void> increaseCartItem(
      CartItemEntity item,
      String userId,
      ) async
  {
    item.increase();

    emit(CartIncrease());

    _scheduleSave(userId);
  }

  Future<void> decreaseCartItem(
      CartItemEntity item,
      String userId,
      ) async
  {
    item.decrease();

    emit(CartDecrease());

    _scheduleSave(userId);
  }

  Future<void> saveCart(String userId) async
  {
    try {
      await cartRepo.saveCart(
        userId: userId,
        cart: cart,
      );
    } catch (e) {
      print(e);
    }
  }

  num getCartItemPrice(
      CartItemEntity item,
      OfferCubit offerCubit,
      )
  {
    final offer = offerCubit.offersMap[item.product.id];

    final unitPrice = getFinalPrice(
      product: item.product,
      offer: offer,
    );

    return unitPrice * item.quantity;
  }

  Future<void> addBundleOffer(
      BundleOfferEntity bundleOffer,
      String userId,
      ) async
  {
    final index = cart.cartItems.indexWhere(
          (item) =>
      item is BundleOfferCartItemEntity &&
          item.bundleOffer.id == bundleOffer.id,
    );

    if (index != -1) {
      final bundleItem =
      cart.cartItems[index] as BundleOfferCartItemEntity;

      bundleItem.increase();
    } else {
      cart = cart.addItem(
        BundleOfferCartItemEntity(
          bundleOffer: bundleOffer,
          quantity: 1,
        ),
      );
    }

    emit(CartAdded());

    _scheduleSave(userId);
  }

  @override
  Future<void> close() async {
    _saveTimer?.cancel();
    await _cartSubscription?.cancel();
    return super.close();
  }
}
