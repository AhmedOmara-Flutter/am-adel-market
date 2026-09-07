part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class GetFavoriteLoadingState extends FavoriteState {}

final class GetFavoriteSuccessState extends FavoriteState {
  final List<ProductEntity> favoriteProducts;

  GetFavoriteSuccessState(this.favoriteProducts);
}

final class GetFavoriteErrorState extends FavoriteState {
  final String error;

  GetFavoriteErrorState({required this.error});
}

final class GetFavoriteEmptyState extends FavoriteState {}

final class FavoriteToggledLoadingState extends FavoriteState {}

final class FavoriteToggledErrorState extends FavoriteState {
  final String errMessage;

  FavoriteToggledErrorState({required this.errMessage});
}

final class FavoriteDeletedState extends FavoriteState {}

final class FavoriteAddedState extends FavoriteState {}
