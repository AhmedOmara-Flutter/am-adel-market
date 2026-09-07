part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitialState extends ProductState {}

final class GetProductsLoadingState extends ProductState {}

final class GetProductsErrorState extends ProductState {
  final String errMessage;

  GetProductsErrorState({required this.errMessage});
}

final class GetProductsSuccessState extends ProductState {
  final List<ProductEntity> products;

  GetProductsSuccessState({required this.products});
}

final class IncreaseSellingCountLoadingState extends ProductState {}

final class IncreaseSellingCountErrorState extends ProductState {
  final String errMessage;

  IncreaseSellingCountErrorState({required this.errMessage});
}

final class IncreaseSellingCountSuccessState extends ProductState {}

final class GetFilteredProductsLoading extends ProductState {}

final class GetFilteredProductsError extends ProductState {
  final String errMessage;
  GetFilteredProductsError(this.errMessage);
}

final class GetFilteredProductsEmpty extends ProductState {}

final class GetFilteredProductsSuccess extends ProductState {
  final List<ProductEntity> filterProducts;

  GetFilteredProductsSuccess({required this.filterProducts});
}

final class DeleteCartLoadingState extends ProductState {}

final class DeleteCartSuccessState extends ProductState {}

final class DeleteCartErrorState extends ProductState {
  final String errMessage;
  DeleteCartErrorState(this.errMessage);
}