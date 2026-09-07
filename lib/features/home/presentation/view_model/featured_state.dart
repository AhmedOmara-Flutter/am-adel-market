part of 'featured_cubit.dart';

@immutable
sealed class FeaturedState {}

final class FeaturedInitial extends FeaturedState {}
final class GetFeaturedProductsLoadingState extends FeaturedState {}

final class GetFeaturedProductsSuccessState extends FeaturedState {
  final List<ProductEntity> featuredProducts;

  GetFeaturedProductsSuccessState({required this.featuredProducts});
}

final class GetFeaturedProductsErrorState extends FeaturedState {
  final String errMessage;

  GetFeaturedProductsErrorState({required this.errMessage});
}
