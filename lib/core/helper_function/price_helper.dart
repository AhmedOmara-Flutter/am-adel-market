import 'package:am_adel_market/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:am_adel_market/features/offers/presentation/view_model/offer_cubit.dart';

import '../entities/product_entity.dart';
import '../../features/offers/domain/entities/offer_entity.dart';

num getFinalPrice({
  required ProductEntity product,
  OfferEntity? offer,
}) {
  if (offer != null && offer.isActive) {
    return offer.priceAfterDiscount;
  }
  return product.price;
}

num getCartTotalPrice(
    CartCubit cartCubit,
    OfferCubit offerCubit,
    ) {
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