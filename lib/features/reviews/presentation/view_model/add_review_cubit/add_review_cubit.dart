import 'dart:async';

import '../../../../../core/utils/app_imports.dart';
import '../../../domain/entities/review_entity.dart';
import '../../../domain/repos/review_repo.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  AddReviewCubit(this._repo) : super(ReviewInitial());
  final ReviewRepo _repo;

  TextEditingController reviewController = TextEditingController();
  double rate = 0;

  void updateRatingField(double p1) {
    rate = p1;
    emit(UpdateRatingField(rate));
  }


  Future<void> addReview(
      ReviewEntity review,
      String productId,
      ) async
  {
    print('start add review');

    emit(AddReviewLoading());
    final result = await _repo.addReview(
      review,
      productId,
    );
    print('add review finished');

    result.fold(
          (failure) {
        print(failure.errMessage);
        emit(AddReviewError(failure.errMessage));
      },
          (_) async {
        emit(AddReviewSuccess());
      },
    );
  }
}
