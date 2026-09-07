import '../entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  const OfferModel({
    required super.productId,
    required super.discountPercentage,
    required super.startDate,
    required super.endDate,
    required super.image,
    required super.name,
    required super.priceBeforeDiscount,
    required super.priceAfterDiscount,
  });

  factory OfferModel.fromEntity(OfferEntity entity) {
    return OfferModel(
      productId: entity.productId,
      discountPercentage: entity.discountPercentage,
      startDate: entity.startDate,
      endDate: entity.endDate,
      image: entity.image,
      name: entity.name,
      priceBeforeDiscount: entity.priceBeforeDiscount,
      priceAfterDiscount: entity.priceAfterDiscount,
    );
  }

  OfferEntity toEntity() {
    return OfferEntity(
      productId: productId,
      discountPercentage: discountPercentage,
      startDate: startDate,
      endDate: endDate,
      image: image,
      name: name,
      priceBeforeDiscount: priceBeforeDiscount,
      priceAfterDiscount: priceAfterDiscount,
    );
  }


  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      productId: json['product_id'] ?? '',
      discountPercentage:
      (json['discount_percentage'] as num?)?.toDouble() ?? 0.0,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      priceBeforeDiscount:
      (json['price_before_discount'] as num?)?.toDouble() ?? 0.0,
      priceAfterDiscount:
      (json['price_after_discount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'discount_percentage': discountPercentage.toDouble(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'image': image,
      'name': name,
      'price_before_discount': priceBeforeDiscount.toDouble(),
      'price_after_discount': priceAfterDiscount.toDouble(),
    };
  }
}
