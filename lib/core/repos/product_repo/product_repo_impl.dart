import 'package:am_adel_market/core/entities/product_entity.dart';
import 'package:am_adel_market/core/models/product_model.dart';
import 'package:am_adel_market/core/repos/product_repo/product_repo.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:dartz/dartz.dart';

import '../../cache/product_cache.dart';

class ProductRepoImpl implements ProductRepo {
  final DatabaseServices _databaseServices;
  final ProductCache _productCache;

  Future<List<ProductEntity>>? _productsLoading;

  ProductRepoImpl(this._databaseServices, this._productCache);

  @override
  Stream<Either<Failure, List<ProductEntity>>> getProducts() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: 'app_settings',
        uId: 'cache_versions',
      )) {
        print('📡 CACHE VERSION STREAM TRIGGERED');

        if (data == null) {
          print('⚠️ CACHE VERSION DATA IS NULL');
          continue;
        }

        final versionData = Map<String, dynamic>.from(data as Map);

        final int? firebaseVersion = (versionData['productsVersion'] as num?)
            ?.toInt();

        print('🔥 FIRESTORE PRODUCTS VERSION: $firebaseVersion');
        print('💾 LOCAL CACHE VERSION: ${_productCache.version}');

        if (firebaseVersion == null) {
          print('⚠️ PRODUCTS VERSION IS NULL');
          continue;
        }

        if (_productCache.hasData && _productCache.version == firebaseVersion) {
          print('🟢 PRODUCTS FROM CACHE');
          print(
            '📦 CACHED PRODUCTS COUNT: '
            '${_productCache.products!.length}',
          );

          yield Right(_productCache.products!);
          continue;
        }

        final products = await (_productsLoading ??= _loadProducts(
          firebaseVersion,
        ));

        yield Right(products);
      }
    } catch (e) {
      print('❌ getProducts error: $e');

      yield Left(
        ServerFailure(errMessage: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  Future<List<ProductEntity>> _loadProducts(int version) async {
    try {
      print('🔴 CACHE MISS - READING PRODUCTS FROM FIRESTORE');

      final productsData =
          await _databaseServices.getData(path: 'products')
              as List<Map<String, dynamic>>;

      print('🔥 PRODUCTS FIRESTORE READ');
      print('📦 PRODUCTS COUNT: ${productsData.length}');

      final products = productsData
          .map((product) => ProductModel.fromJson(product).toEntity())
          .toList();

      _productCache.save(products: products, version: version);

      print('💾 PRODUCTS SAVED TO CACHE');
      print('💾 CACHE VERSION: ${_productCache.version}');

      return products;
    } finally {
      _productsLoading = null;
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
        final products = data
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
  ) async {
    try {
      print('🔎 SEARCH PRODUCTS');
      print('🔎 SEARCH QUERY: "$query"');

      if (!_productCache.hasData) {
        print('⚠️ PRODUCT CACHE IS EMPTY');
        print('❌ SEARCH ABORTED - NO FIRESTORE READ');
        return const Right([]);
      }

      print('🟢 SEARCHING FROM PRODUCT CACHE');
      print(
        '📦 CACHED PRODUCTS COUNT: '
        '${_productCache.products!.length}',
      );
      print('💾 CACHE VERSION: ${_productCache.version}');

      final products = _productCache.products!
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      print('✅ SEARCH COMPLETED');
      print('📦 SEARCH RESULTS COUNT: ${products.length}');

      return Right(products);
    } catch (e) {
      print('❌ SEARCH PRODUCTS ERROR: $e');

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
  Future<void> deleteCollection(String collectionName) async {
    return await _databaseServices.deleteCollection(collectionName);
  }
}
