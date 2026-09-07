part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ProductEntity> products;

  SearchSuccess(this.products);
}

final class SearchError extends SearchState {
  final String errMessage;

  SearchError(this.errMessage);
}

final class SearchEmpty extends SearchState {
  final String? query;

  SearchEmpty([this.query]);
}
