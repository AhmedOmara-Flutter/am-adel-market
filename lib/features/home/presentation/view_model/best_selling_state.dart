part of 'best_selling_cubit.dart';

@immutable
sealed class BestSellingState {}

final class BestSellingInitial extends BestSellingState {}

final class GetSellingProductsLoadingState extends BestSellingState {}

final class GetSellingProductsEmptyState extends BestSellingState {}

final class GetSellingProductsSuccessState extends BestSellingState {
  final List<ProductEntity> sellingProducts;

  GetSellingProductsSuccessState({required this.sellingProducts});
}

final class GetSellingProductsErrorState extends BestSellingState {
  final String errMessage;

  GetSellingProductsErrorState({required this.errMessage});
}
