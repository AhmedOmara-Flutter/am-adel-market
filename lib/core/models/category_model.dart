class CategoryModel {
  final String id;
  final String name;
  final List<String> sizes;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.sizes,
  });

  factory CategoryModel.fromMap(
      Map<String, dynamic> map,
      String id,
      ) {
    return CategoryModel(
      id: id,
      name: map['name'] ?? '',
      sizes: List<String>.from(map['sizes'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sizes': sizes,
    };
  }
}