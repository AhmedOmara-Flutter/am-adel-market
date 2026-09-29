import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/errors/failure.dart';
import 'package:am_adel_market/core/services/database_services.dart';
import 'package:am_adel_market/features/reviews/data/models/review_model.dart';
import 'package:am_adel_market/features/reviews/domain/entities/review_entity.dart';
import 'package:am_adel_market/features/reviews/domain/repos/review_repo.dart';

class ReviewRepoImpl implements ReviewRepo {
  final DatabaseServices _databaseServices;

  ReviewRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, void>> addReview(ReviewEntity review,
      String productId,) async {
    try {
      await _databaseServices.addData(
        path: 'products/$productId/reviews',
        data: ReviewModel.fromEntity(review).toJson(),
        uId: null,
      );

      final product =
          await _databaseServices.getData(path: 'products', uId: productId)
              as Map<String, dynamic>;

      final currentCount = (product['reviewsCount'] ?? 0) as num;
      final currentSum = (product['ratingSum'] ?? 0) as num;

      final newCount = currentCount + 1;
      final newSum = currentSum + review.rating;
      final newAvg = newSum / newCount;

      await _databaseServices.updateData(
        path: 'products',
        docId: productId,
        data: {
          'reviewsCount': newCount,
          'ratingSum': newSum,
          'averageRating': newAvg,
        },
      );

      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ReviewEntity>>> getReviews(
    String productId,
  ) async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
          in _databaseServices.getStreamData(
            path: 'products/$productId/reviews',
            query: {'orderBy': 'date', 'descending': true},
          )) {
        List<ReviewEntity> reviews = (data as List)
            .map((e) => ReviewModel.fromJson(e).toEntity())
            .toList();

        yield right(reviews);
      }
    } catch (e) {
      yield left(ServerFailure(errMessage: e.toString()));
    }
  }
}
