import 'package:am_adel_market/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.product,
    required super.unitPrice,
    required super.quantity,
  });

  factory CartItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CartItemModel(
      product: ProductModel
          .fromJson(json['product'])
          .toEntity(),
      unitPrice: (json['unitPrice'] ?? 0) as num,
      quantity: (json['quantity'] ?? 1) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': 'product',
      'product': ProductModel
          .fromEntity(product)
          .toJson(),
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory CartItemModel.fromEntity(
      CartItemEntity entity,
      ) {
    return CartItemModel(
      product: entity.product,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product,
      quantity: quantity,
      unitPrice: unitPrice,
    );
  }
}