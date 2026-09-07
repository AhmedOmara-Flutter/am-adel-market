import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/features/favorite/domain/repos/favorite_repo.dart';
import 'package:am_adel_market/core/entities/product_entity.dart';

import '../../../../core/utils/app_imports.dart';
import '../../../../core/models/product_model.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final DatabaseServices _databaseServices;

  FavoriteRepoImpl(this._databaseServices);

  final path = 'users/${getUser().uId}/favorites';

  @override
  Future<Either<String, bool>> toggleFavorite(ProductEntity product) async {
    try {
      final productId = product.id;
      final exists = await _databaseServices.checkExists(
        path: path,
        uId: productId,
      );
      if (exists) {
        await _databaseServices.deleteData(path: path, uId: productId);
        return const Right(false);
      } else {
        await _databaseServices.addData(
          path: path,
          uId: productId,
          data: ProductModel.fromEntity(product).toJson(),
        );

        return const Right(true);
      }
    } catch (e) {
      //todo show this
       //return Left(ServerFailure(errMessage: e.toString()));
      return Left(e.toString());
    }
  }

  @override
  Stream<Either<String, List<ProductEntity>>> getFavoriteProducts() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: path,
      )) {
        final result = (data as List)
            .map((e) => ProductModel.fromJson(e).toEntity())
            .toList();

        yield Right(result);
      }


    } catch (e) {
      yield Left(e.toString());
    }
  }
}
