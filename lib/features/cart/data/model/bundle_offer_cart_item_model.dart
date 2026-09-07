
import '../../../../core/entities/bundle_offer_entity.dart';
import '../../domain/entities/bundle_offer_cart_item_entity.dart';

class BundleOfferCartItemModel
    extends BundleOfferCartItemEntity {

  BundleOfferCartItemModel({
    required super.bundleOffer,
    required super.quantity,
  });

  // ===========================================================
  // NEW FORMAT
  // ===========================================================

  factory BundleOfferCartItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final data = Map<String, dynamic>.from(
      json['bundleOffer'] ?? {},
    );

    return BundleOfferCartItemModel(
      bundleOffer: BundleOfferEntity(
        id: data['id'] as String?,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        image: data['image'] as String?,
        createdAt: DateTime.tryParse(
          data['createdAt'] ?? '',
        ) ??
            DateTime.now(),
      ),
      quantity: (json['quantity'] ?? 1) as int,
    );
  }

  // ===========================================================
  // OLD FORMAT
  // product.category == bundle_offer
  // ===========================================================

  factory BundleOfferCartItemModel.fromOldCartJson(
      Map<String, dynamic> json,
      ) {
    final product =
    Map<String, dynamic>.from(
      json['product'],
    );

    return BundleOfferCartItemModel(
      bundleOffer: BundleOfferEntity(
        id: product['id'] as String?,
        title: product['name'] ?? '',
        description: product['description'] ?? '',
        price: (product['price'] ?? 0).toDouble(),
        image: product['image'] as String?,
        createdAt: DateTime.tryParse(
          product['createdAt'] ?? '',
        ) ??
            DateTime.now(),
      ),
      quantity: (json['quantity'] ?? 1) as int,
    );
  }

  // ===========================================================
  // SAVE NEW FORMAT
  // ===========================================================

  Map<String, dynamic> toJson() {
    return {
      'type': 'bundleOffer',
      'quantity': quantity,
      'bundleOffer': {
        'id': bundleOffer.id,
        'title': bundleOffer.title,
        'description': bundleOffer.description,
        'price': bundleOffer.price,
        'image': bundleOffer.image,
        'createdAt':
        bundleOffer.createdAt.toIso8601String(),
      },
    };
  }

  factory BundleOfferCartItemModel.fromEntity(
      BundleOfferCartItemEntity entity,
      ) {
    return BundleOfferCartItemModel(
      bundleOffer: entity.bundleOffer,
      quantity: entity.quantity,
    );
  }

  BundleOfferCartItemEntity toEntity() {
    return BundleOfferCartItemEntity(
      bundleOffer: bundleOffer,
      quantity: quantity,
    );
  }
}