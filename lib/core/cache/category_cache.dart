
import '../../features/category/domain/entities/category_entity.dart';

class CategoryCache {
  List<CategoryEntity>? categories;
  int? version;

  bool get hasData => categories != null;

  void save({
    required List<CategoryEntity> categories,
    required int version,
  }) {
    this.categories = categories;
    this.version = version;
  }

  void clear() {
    categories = null;
    version = null;
  }
}