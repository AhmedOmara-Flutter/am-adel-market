import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/database_services.dart';
import '../../data/models/order_review_model.dart';
import '../../data/repos/order_review_repo.dart';
import '../entities/order_review_entity.dart';

class OrderReviewRepoImpl implements OrderReviewRepo {
  final DatabaseServices _databaseServices;

  OrderReviewRepoImpl(this._databaseServices);


  @override
  Future<Either<Failure, void>> submitReview(
      OrderReviewEntity review,
      ) async {
    try {
      if (review.orderId.trim().isEmpty) {
        throw Exception('رقم الطلب غير صالح');
      }

      if (review.userId.trim().isEmpty) {
        throw Exception('المستخدم غير مسجل الدخول');
      }

      if (review.foodRating < 1 ||
          review.foodRating > 5 ||
          review.driverRating < 1 ||
          review.driverRating > 5) {
        throw Exception('يرجى تقييم جودة الأكل والمندوب');
      }

      final model = OrderReviewModel.fromEntity(review);

      final created = await _databaseServices.createDataIfAbsent(
        path: 'order_reviews',
        docId: review.orderId,
        data: model.toJson(),
      );

      if (!created) {
        throw Exception('لقد قمت بتقييم هذا الطلب من قبل');
      }

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> hasReviewed(String orderId) async {
    try {
      final exists = await _databaseServices.checkExists(
        path: 'order_reviews',
        uId: orderId,
      );

      return Right(exists);
    } catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}