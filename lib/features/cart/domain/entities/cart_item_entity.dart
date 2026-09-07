import 'package:equatable/equatable.dart';
import 'package:am_adel_market/core/entities/product_entity.dart';

// ignore_for_file: must_be_immutable
class CartItemEntity extends Equatable  {
  final ProductEntity product;
  final num unitPrice;

  int quantity;

  CartItemEntity({
    required this.product,
    this.quantity = 1,
    required this.unitPrice,
  });

  num get totalPrice => unitPrice * quantity;
  void increase() {
    quantity++;
  }

  void decrease() {
    if (quantity > 1) {
      quantity--;
    }
  }


  String get totalWeightText {
    final totalGrams = product.unitAmount * quantity;

    if (totalGrams < 1000) {
      return '$totalGrams جم';
    } else {
      final kg = totalGrams / 1000;
      return kg % 1 == 0
          ? '${kg.toInt()} كجم'
          : '${kg.toStringAsFixed(2)} كجم';
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [product, quantity];
}