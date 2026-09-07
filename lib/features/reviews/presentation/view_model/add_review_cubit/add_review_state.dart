part of 'add_review_cubit.dart';

@immutable
sealed class AddReviewState {}

final class ReviewInitial extends AddReviewState {}

final class UpdateRatingField extends AddReviewState {
  final double rate;
  UpdateRatingField(this.rate);
}

final class AddReviewLoading extends AddReviewState {}

final class AddReviewSuccess extends AddReviewState {}

final class AddReviewError extends AddReviewState {
  final String errMessage;

  AddReviewError(this.errMessage);
}

