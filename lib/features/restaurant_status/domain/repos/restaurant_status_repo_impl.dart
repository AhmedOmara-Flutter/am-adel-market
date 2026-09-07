import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/database_services.dart';
import '../../data/models/restaurant_status_model.dart';
import '../../data/repos/restaurant_status_repo.dart';
import '../entities/restaurant_status_entity.dart';

class RestaurantStatusRepoImpl implements RestaurantStatusRepo {
  final DatabaseServices _databaseServices;

  RestaurantStatusRepoImpl(this._databaseServices);

  static const String _path = 'app_settings';
  static const String _docId = 'restaurant';

  @override
  Stream<Either<Failure, RestaurantStatusEntity>> watchRestaurantStatus() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: _path,
        uId: _docId,
      )) {
        print('🔥 FIRESTORE RAW DATA => $data');
        print('🔥 isOpen RAW VALUE => ${data['isOpen']}');
        print('🔥 isOpen RAW TYPE => ${data['isOpen'].runtimeType}');

        final map = Map<String, dynamic>.from(data);

        if (map.isEmpty) {
          yield const Right(RestaurantStatusModel(isOpen: true));
          continue;
        }

        final model = RestaurantStatusModel.fromJson(map);

        print('🔥 MODEL isOpen => ${model.isOpen}');

        yield Right(model);
      }
    } catch (e) {
      yield Left(Failure(errMessage: e.toString()));
    }
  }
}
