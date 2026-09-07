import 'package:dartz/dartz.dart';
import '../../../../core/entities/product_entity.dart';

abstract class FavoriteRepo {
  Future<Either<String, bool>> toggleFavorite(ProductEntity product);
  Stream<Either<String, List<ProductEntity>>> getFavoriteProducts();
}