
import '../../../../core/entities/bundle_offer_entity.dart';
import '../../../../core/entities/product_entity.dart';
import 'cart_item_entity.dart';

class BundleOfferCartItemEntity extends CartItemEntity {
  final BundleOfferEntity bundleOffer;

  BundleOfferCartItemEntity({
    required this.bundleOffer,
    int quantity = 1,
  }) : super(
    product: ProductEntity(
      id: bundleOffer.id ?? '',
      name: bundleOffer.title,
      code: 'bundle_${bundleOffer.id ?? ''}',
      price: bundleOffer.price,
      description: bundleOffer.description,
      image: bundleOffer.image,
      isFeatured: false,
      expirationMonth: 0,
      unitAmount: 0,
      numberOfCalories: 0,
      isOrganic: false,
      sellingCount: 0,
      averageRating: 0,
      reviewsCount: 0,
      ratingSum: 0,
      category: 'bundle_offer',
      createdAt: bundleOffer.createdAt.toIso8601String(),
    ),
    unitPrice: bundleOffer.price,
    quantity: quantity,
  );

  bool get isBundleOffer => true;
}