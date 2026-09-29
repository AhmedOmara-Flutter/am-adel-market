import '../entities/product_entity.dart';

class ProductCache {
  List<ProductEntity>? products;
  int? version;

  bool get hasData => products != null;

  void save({
    required List<ProductEntity> products,
    required int version,
  }) {
    this.products = products;
    this.version = version;
  }

  void clear() {
    products = null;
    version = null;
  }
}