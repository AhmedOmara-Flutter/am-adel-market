import '../../../../../core/services/database_services.dart';
import '../../data/models/category_model.dart';
import '../../data/repos/category_repo.dart';
import '../entities/category_entity.dart';

class CategoryRepoImpl implements CategoryRepo {
  final DatabaseServices _databaseServices;

  CategoryRepoImpl(this._databaseServices);

  static const String _collection = 'categories';

  @override
  Stream<List<CategoryEntity>> getCategoriesStream() {
    return _databaseServices
        .getStreamData(
      path: _collection,
      query: {
        'orderBy': 'sortOrder',
        'descending': false,
      },
    )
        .map((data) {
      final List categories = data as List;

      return categories
          .map(
            (json) => CategoryModel.fromJson(
          Map<String, dynamic>.from(json),
        ).toEntity(),
      )
          .toList();
    });
  }
}