import 'package:am_adel_market/features/cart/domain/entities/bundle_offer_cart_item_entity.dart';

import '../../domain/entities/cart_entity.dart';
import 'bundle_offer_cart_item_model.dart';
import 'cart_item_model.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json,) {
    final List<dynamic> items =
        json['cartItems'] as List? ?? [];

    return CartModel(
      cartItems: items.map((e) {
        final item = Map<String, dynamic>.from(e);

        // =====================================================
        // NEW BUNDLE FORMAT
        // =====================================================

        if (item['type'] == 'bundleOffer') {
          return BundleOfferCartItemModel
              .fromJson(item)
              .toEntity();
        }

        // =====================================================
        // OLD BUNDLE FORMAT
        // category == bundle_offer
        // =====================================================

        final product = item['product'];

        if (product is Map &&
            product['category'] == 'bundle_offer') {
          return BundleOfferCartItemModel.fromOldCartJson(
            item,
          ).toEntity();
        }

        // =====================================================
        // NORMAL PRODUCT
        // =====================================================

        return CartItemModel
            .fromJson(item)
            .toEntity();
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItems': cartItems.map((item) {
        // =====================================================
        // BUNDLE
        // =====================================================

        if (item is BundleOfferCartItemEntity) {
          return BundleOfferCartItemModel
              .fromEntity(item)
              .toJson();
        }

        // =====================================================
        // NORMAL PRODUCT
        // =====================================================

        return CartItemModel
            .fromEntity(item)
            .toJson();
      }).toList(),
    };
  }

  factory CartModel.fromEntity(CartEntity entity,) {
    return CartModel(
      cartItems: entity.cartItems,
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      cartItems: cartItems,
    );
  }
}