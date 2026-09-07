import '../../domain/entities/category_entity.dart';

abstract class CategoryRepo {
  Stream<List<CategoryEntity>> getCategoriesStream();
}