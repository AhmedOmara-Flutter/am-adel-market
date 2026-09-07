import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/review_entity.dart';
import '../../../domain/repos/review_repo.dart';
part 'get_review_state.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  GetReviewCubit(this._repo) : super(GetReviewInitial());
  StreamSubscription? _reviewSubscription;
  List<ReviewEntity> reviews = [];
  final ReviewRepo _repo;
  
  void getReviews(String productId) {
    emit(GetReviewLoading());

    _reviewSubscription = _repo.getReviews(productId).listen((data) {
      data.fold(
        (failure) {
          print(failure.errMessage);
          emit(GetReviewError(failure.errMessage));
        },
        (reviewsData) {
          reviews = reviewsData;
          emit(GetReviewSuccess());
        },
      );
    });
  }

  double get averageRating {
    if (reviews.isEmpty) {
      return 0.0;
    }
    double totalRating = 0.0;
    for (var review in reviews) {
      totalRating += review.rating;
    }
    totalRating = double.parse(
      (totalRating / reviews.length).toStringAsFixed(2),
    );
    return totalRating;
  }

  double get recommendedPercentage {
    if (reviews.isEmpty) return 0.0;

    final goodReviews = reviews.where((r) => r.rating >= 4).length;

    return double.parse(
      ((goodReviews / reviews.length) * 100).toStringAsFixed(1),
    );
  }

  double getPercentage(int star) {
    if (reviews.isEmpty) return 0;

    final count = reviews.where((r) => r.rating.round() == star).length;

    return count / reviews.length;
  }

  @override
  Future<void> close() {
    _reviewSubscription?.cancel();
    return super.close();
  }
}
