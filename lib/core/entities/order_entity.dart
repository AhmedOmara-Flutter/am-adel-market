import 'dart:io';

import 'package:am_adel_market/features/checkout/domain/entities/selected_location_entity.dart';

import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/cart/domain/entities/cart_entity.dart';
import '../enums/order_enum.dart';
import '../../features/checkout/domain/entities/address_entity.dart';

class OrderEntity {
  String? id;
  final String uId;
  final DateTime? createdAt;
  final CartEntity cartEntity;
  final UserEntity? userEntity;
  bool? isCashOnDelivery;
  AddressEntity? addressEntity;
  SelectedLocationEntity? selectedLocationEntity;
  final OrderStatus status;
  File? paymentFileImage;
  String? paymentImage;
  String? orderNote;
  double totalPrice;
  double couponDiscount;

  OrderEntity({
    required this.cartEntity,
    this.isCashOnDelivery,
    this.addressEntity,
    required this.uId,
    this.id,
    this.createdAt,
    this.userEntity,
    required this.status,
    this.selectedLocationEntity,
    this.paymentImage,
    this.orderNote,
    this.totalPrice = 0,
    this.couponDiscount = 0,
  });

  String getFullAddress() {
    return '${addressEntity!.address}';
  }
}
