import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/helper_function/get_user.dart';
import '../../data/models/order_review_model.dart';
import '../../data/repos/order_review_repo.dart';

part 'order_review_state.dart';

class OrderReviewCubit extends Cubit<OrderReviewState> {
  OrderReviewCubit(this._repo) : super(OrderReviewInitial());

  final OrderReviewRepo _repo;

  Future<void> submitReview({
    required String orderId,
    required int foodRating,
    required String foodReview,
    required int driverRating,
    required String driverReview,
  }) async {
    if (state is OrderReviewLoading) return;

    if (orderId.trim().isEmpty) {
      emit(OrderReviewError('رقم الطلب غير صالح'));
      return;
    }

    if (foodRating < 1 ||
        foodRating > 5 ||
        driverRating < 1 ||
        driverRating > 5) {
      emit(OrderReviewError('يرجى تقييم جودة الأكل والمندوب'));
      return;
    }

    emit(OrderReviewLoading());

    try {
      final user = getUser();

      final review = OrderReviewModel(
        orderId: orderId,
        userId: user.uId,
        foodRating: foodRating,
        foodReview: foodReview.trim(),
        driverRating: driverRating,
        driverReview: driverReview.trim(),
        createdAt: DateTime.now(),
      );

      final result = await _repo.submitReview(review);

      if (isClosed) return;

      result.fold(
            (failure) {
          if (failure.errMessage.contains(
            'لقد قمت بتقييم هذا الطلب من قبل',
          )) {
            emit(OrderReviewAlreadySubmitted());
          } else {
            emit(
              OrderReviewError(
                failure.errMessage.isNotEmpty
                    ? failure.errMessage
                    : 'تعذر إرسال التقييم، حاول مرة أخرى',
              ),
            );
          }
        },
            (_) => emit(OrderReviewSuccess()),
      );
    } catch (_) {
      if (!isClosed) {
        emit(
          OrderReviewError(
            'حدث خطأ أثناء إرسال التقييم، حاول مرة أخرى',
          ),
        );
      }
    }
  }

  Future<void> checkIfReviewed(String orderId) async {
    if (orderId.trim().isEmpty) return;

    final result = await _repo.hasReviewed(orderId);

    if (isClosed) return;

    result.fold(
          (failure) {
        emit(OrderReviewError(failure.errMessage));
      },
          (hasReviewed) {
        if (hasReviewed) {
          emit(OrderReviewAlreadySubmitted());
        } else {
          emit(OrderReviewInitial());
        }
      },
    );
  }
}
