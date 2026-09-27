part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}
final class CheckoutChangePage extends CheckoutState {}
final class CheckoutChangeLocationIndex extends CheckoutState {}
final class CheckoutSelectShipping extends CheckoutState {}
final class CheckoutOrderConfirmed extends CheckoutState {}
final class CheckoutAddOrderLoading extends CheckoutState {}
final class CheckoutAddOrderError extends CheckoutState {
  final String error;
  CheckoutAddOrderError(this.error);
}
final class CheckoutAddOrderSuccess extends CheckoutState {}
final class CheckoutGetOrderLoading extends CheckoutState {}
final class CheckoutGetOrderError extends CheckoutState {
  final String error;
  CheckoutGetOrderError(this.error);
}
final class CheckoutGetOrderSuccess extends CheckoutState {}
final class CheckoutLocationsUpdated extends CheckoutState {}

final class CheckoutLocationsError extends CheckoutState {
  final String message;

  CheckoutLocationsError(this.message);
}

class CheckoutLocationsLoading extends CheckoutState {}

final class CheckoutCouponLoading extends CheckoutState {}

final class CheckoutCouponError extends CheckoutState {
  final String error;

  CheckoutCouponError(this.error);
}

final class CheckoutCouponSuccess extends CheckoutState {}
class CheckoutCouponRemoved extends CheckoutState {}