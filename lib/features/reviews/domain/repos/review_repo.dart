import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/errors/failure.dart';
import 'package:am_adel_market/features/reviews/domain/entities/review_entity.dart';

abstract class ReviewRepo {
  Future<Either<Failure, void>> addReview(
      ReviewEntity review,
      String productId,
      );

  Stream<Either<Failure, List<ReviewEntity>>> getReviews(
      String productId,
      );
}