import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/restaurant_status_entity.dart';

abstract class RestaurantStatusRepo {
  Stream<Either<Failure, RestaurantStatusEntity>> watchRestaurantStatus();
}