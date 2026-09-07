import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/errors/failure.dart';
import 'package:am_adel_market/core/entities/order_entity.dart';

abstract class OrderRepo {
  Future<Either<Failure, String>> addOrder(OrderEntity orderEntity);
  Stream<Either<Failure, List<OrderEntity>>> getOrder(String uId);


}
