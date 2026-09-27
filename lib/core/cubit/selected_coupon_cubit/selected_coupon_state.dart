part of 'selected_coupon_cubit.dart';

@immutable
sealed class SelectedCouponState {}

final class SelectedCouponInitial extends SelectedCouponState {}

final class SelectedCouponSelected extends SelectedCouponState {
  final String code;

  SelectedCouponSelected(this.code);
}