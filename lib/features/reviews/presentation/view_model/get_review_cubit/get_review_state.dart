part of 'get_review_cubit.dart';

@immutable
sealed class GetReviewState {}

final class GetReviewInitial extends GetReviewState {}

final class GetReviewLoading extends GetReviewState {}

final class GetReviewSuccess extends GetReviewState {}

final class GetReviewError extends GetReviewState {
  final String errMessage;

  GetReviewError(this.errMessage);
}

