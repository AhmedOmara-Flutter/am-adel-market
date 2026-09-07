part of 'restaurant_status_cubit.dart';

@immutable
sealed class RestaurantStatusState {}

final class RestaurantStatusInitial extends RestaurantStatusState {}

final class RestaurantStatusLoaded extends RestaurantStatusState {
  final RestaurantStatusEntity restaurantStatus;

  RestaurantStatusLoaded({
    required this.restaurantStatus,
  });
}

final class RestaurantStatusError extends RestaurantStatusState {
  final String message;

  RestaurantStatusError({
    required this.message,
  });
}