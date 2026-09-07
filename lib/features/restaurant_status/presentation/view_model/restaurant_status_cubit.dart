import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_imports.dart';
import '../../data/repos/restaurant_status_repo.dart';
import '../../domain/entities/restaurant_status_entity.dart';
part 'restaurant_status_state.dart';

class RestaurantStatusCubit extends Cubit<RestaurantStatusState> {
  final RestaurantStatusRepo _repo;

  StreamSubscription<Either<Failure, RestaurantStatusEntity>>?
  _subscription;

  RestaurantStatusCubit(this._repo)
      : super(RestaurantStatusInitial());

  void startListening() {
    if (isClosed) return;

    _subscription?.cancel();

    _subscription = _repo.watchRestaurantStatus().listen(
          (result) {
        if (isClosed) return;

        result.fold(
              (failure) {
            emit(
              RestaurantStatusError(
                message: failure.errMessage,
              ),
            );
          },
              (status) {
            emit(
              RestaurantStatusLoaded(
                restaurantStatus: status,
              ),
            );
          },
        );
      },
      onError: (error) {
        if (isClosed) return;

        emit(
          RestaurantStatusError(
            message: error.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    _subscription = null;

    return super.close();
  }
}