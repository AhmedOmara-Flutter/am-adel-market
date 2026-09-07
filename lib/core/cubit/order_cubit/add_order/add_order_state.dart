part of 'add_order_cubit.dart';

@immutable
sealed class AddOrderState {}

final class AddOrderInitial extends AddOrderState {}
final class CheckoutAddOrderLoading extends AddOrderState {}
final class CheckoutAddOrderError extends   AddOrderState {
  final String error;
  CheckoutAddOrderError(this.error);
}
final class CheckoutAddOrderSuccess extends AddOrderState {}
