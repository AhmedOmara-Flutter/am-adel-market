import 'dart:io';

import 'package:equatable/equatable.dart';

// ignore_for_file: must_be_immutable
class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String code;
  final num price;
  final String description;
  final File ?imageFile;
  final bool isFeatured;
  String? image;
  final num expirationMonth;
  final num unitAmount;
  final num numberOfCalories;
  final bool isOrganic;
  int sellingCount;
  List<String> ?subImages;
  double averageRating;
  int reviewsCount;
  double ratingSum;
  final String category;
  final String createdAt;
  String? offerId;
  final String ?size;
  final bool isPaused;


  ProductEntity({
    required this.name,
    required this.code,
    required this.price,
    required this.description,
     this.imageFile,
    required this.isFeatured,
    this.image,
    required this.expirationMonth,
    required this.unitAmount,
    required this.numberOfCalories,
    this.isOrganic = false,
    this.sellingCount = 0,
    required this.id,
    this.subImages,
    required this.averageRating,
    required this.reviewsCount,
    required this.ratingSum,
    required this.category,
    required this.createdAt,
    this.offerId,
    this.size,
    this.isPaused = false,
  });


  @override
  // TODO: implement props
  List<Object?> get props => [
    code,
    id,
    name,
    price,
    description,
    imageFile,
    isFeatured,
    image,
    expirationMonth,
    unitAmount,
    numberOfCalories,
    isOrganic,
    sellingCount,
    subImages,
    averageRating,
    reviewsCount,
    ratingSum,
    category,
    createdAt,
    offerId,
    size,
    isPaused,
  ];
}
