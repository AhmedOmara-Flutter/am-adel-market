import 'package:equatable/equatable.dart';
import 'package:am_adel_market/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:am_adel_market/features/offers/presentation/view_model/offer_cubit.dart';

import '../../../../core/helper_function/price_helper.dart';
import '../../../../core/entities/product_entity.dart';
import 'cart_item_entity.dart';

class CartEntity extends Equatable{
  final List<CartItemEntity> cartItems;

  const CartEntity({required this.cartItems});

  CartEntity addItem(CartItemEntity item) {
    final updated = List<CartItemEntity>.from(cartItems);
    updated.add(item);
    return CartEntity(cartItems: updated);
  }

  CartEntity removeItem(CartItemEntity item) {
    final updated = List<CartItemEntity>.from(cartItems);
    updated.remove(item);
    return CartEntity(cartItems: updated);
  }

  int getItemsCount() {
    int count = 0;
    for (CartItemEntity cartItem in cartItems) {
      count += cartItem.quantity;
    }
    return count;
  }

  num getTotalPrice() {
    num total = 0;
    for (var item in cartItems) {
      total += item.totalPrice;
    }
    return total;
  }



  num getCartTotalPrice(CartCubit cartCubit, OfferCubit offerCubit) {
    num total = 0;

    for (final item in cartCubit.cart.cartItems) {
      final offer = offerCubit.offersMap[item.product.id];

      final unitPrice = getFinalPrice(
        product: item.product,
        offer: offer,
      );

      total += unitPrice * item.quantity;
    }

    return total;
  }

  bool isExist(ProductEntity product) {
    for (CartItemEntity cartItem in cartItems) {
      if (cartItem.product.code == product.code) return true;
    }
    return false;
  }


  @override
  List<Object?> get props => [cartItems];
}
