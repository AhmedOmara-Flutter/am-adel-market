import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/order_review_entity.dart';

abstract class OrderReviewRepo {
  Future<Either<Failure, void>> submitReview(
      OrderReviewEntity review,
      );

  Future<Either<Failure, bool>> hasReviewed(String orderId);
}