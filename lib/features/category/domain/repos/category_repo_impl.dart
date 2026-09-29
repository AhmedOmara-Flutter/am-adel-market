import 'package:dartz/dartz.dart';

import '../../../../../core/cache/category_cache.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/database_services.dart';
import '../../data/models/category_model.dart';
import '../../data/repos/category_repo.dart';
import '../entities/category_entity.dart';

class CategoryRepoImpl implements CategoryRepo {
  final DatabaseServices _databaseServices;
  final CategoryCache _categoryCache;

  Future<List<CategoryEntity>>? _categoriesLoading;

  CategoryRepoImpl(this._databaseServices, this._categoryCache);

  static const String _collection = 'categories';

  @override
  Stream<List<CategoryEntity>> getCategoriesStream() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: 'app_settings',
        uId: 'cache_versions',
      )) {
        print('📡 CATEGORY VERSION STREAM TRIGGERED');

        if (data == null) {
          print('⚠️ CATEGORY VERSION DATA IS NULL');
          continue;
        }

        final versionData = Map<String, dynamic>.from(data as Map);

        final int? firebaseVersion =
        (versionData['categoriesVersion'] as num?)?.toInt();

        print('🔥 FIRESTORE CATEGORIES VERSION: $firebaseVersion');
        print('💾 LOCAL CATEGORY CACHE VERSION: ${_categoryCache.version}');

        if (firebaseVersion == null) {
          print('⚠️ CATEGORIES VERSION IS NULL');
          continue;
        }

        if (_categoryCache.hasData &&
            _categoryCache.version == firebaseVersion) {
          print('🟢 CATEGORIES FROM CACHE');
          print(
            '📦 CACHED CATEGORIES COUNT: '
                '${_categoryCache.categories!.length}',
          );

          yield _categoryCache.categories!;
          continue;
        }

        print('🟡 CATEGORY CACHE MISS');

        final categories = await (_categoriesLoading ??= _loadCategories(
          firebaseVersion,
        ));

        print('✅ CATEGORIES LOADED');
        print('📦 CATEGORIES COUNT: ${categories.length}');

        yield categories;
      }
    } catch (e) {
      print('❌ getCategoriesStream error: $e');

      throw Exception(e.toString());
    }
  }

  Future<List<CategoryEntity>> _loadCategories(int version) async {
    try {
      print('🔴 READING CATEGORIES FROM FIRESTORE');

      final data =
      await _databaseServices.getData(
        path: _collection,
        query: {
          'orderBy': 'sortOrder',
          'descending': false,
        },
      )
      as List<Map<String, dynamic>>;

      print('🔥 CATEGORIES FIRESTORE READ');
      print('📦 CATEGORIES COUNT: ${data.length}');

      final categories = data
          .map(
            (json) => CategoryModel.fromJson(json).toEntity(),
      )
          .toList();

      _categoryCache.save(
        categories: categories,
        version: version,
      );

      print('💾 CATEGORIES SAVED TO CACHE');
      print('💾 CATEGORY CACHE VERSION: ${_categoryCache.version}');

      return categories;
    } finally {
      _categoriesLoading = null;
    }
  }
}