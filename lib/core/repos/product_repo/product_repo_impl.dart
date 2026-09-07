import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/entities/product_entity.dart';
import 'package:am_adel_market/core/models/product_model.dart';
import 'package:am_adel_market/core/repos/product_repo/product_repo.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

class ProductRepoImpl implements ProductRepo {
  final DatabaseServices _databaseServices;
  ProductRepoImpl(this._databaseServices);

  @override
  Stream<Either<Failure, List<ProductEntity>>> getProducts() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
          in _databaseServices.getStreamData(path: 'products')) {
        List<ProductEntity> products = data
            .map((product) => ProductModel.fromJson(product).toEntity())
            .toList();
        yield Right(products);
      }
    } on Exception catch (e) {
      print(e);
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ProductEntity>>> getSellingProducts() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
          in _databaseServices.getStreamData(
            path: 'products',
            query: {'limit': 20, 'orderBy': 'sellingCount', 'descending': true},
          )) {
        List<ProductEntity> products = data
            .map((product) => ProductModel.fromJson(product).toEntity())
            .toList();
        yield Right(products);
      }
    } catch (e) {
      print(e);
      yield Left(
        ServerFailure(errMessage: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
    String query,
  )
  async {
    try {
      final data =
          await _databaseServices.getData(path: 'products')
              as List<Map<String, dynamic>>;
      final products = data
          .map((e) => ProductModel.fromJson(e).toEntity())
          .where((product) {
        return product.name
            .toLowerCase()
            .contains(query.toLowerCase());
      })
          .toList();
      return Right(products);
    } catch (e) {
      print(e);
      return Left(
        ServerFailure(errMessage: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  @override
  Future<Either<Failure, void>> increaseSellingCount(String productId) async {
    try {
      final data = await _databaseServices.updateData(
        path: 'products',
        data: {'sellingCount': FieldValue.increment(1)},
        docId: productId,
      );

      return Right(data);
    } catch (e) {
      print('increaseSellingCount is failed with error $e');
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> deleteCollection(String collectionName)async {
    return await _databaseServices.deleteCollection(collectionName);
  }
}
