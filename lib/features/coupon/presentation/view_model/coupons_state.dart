part of 'coupons_cubit.dart';

@immutable
abstract class CouponsState {}

class CouponsInitial extends CouponsState {}

class CouponsLoading extends CouponsState {}

class CouponsSuccess extends CouponsState {
  final List<CouponEntity> coupons;

  CouponsSuccess(this.coupons);
}

class CouponsFailure extends CouponsState {
  final String message;

  CouponsFailure(this.message);
}