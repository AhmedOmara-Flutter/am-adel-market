import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/products_grid_view.dart';
import '../../../../core/entities/product_entity.dart';

class BuildSearchSuccess extends StatelessWidget {
  final List<ProductEntity> products;
  const BuildSearchSuccess({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'نتائج البحث',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),

        ProductsGridView(products: products),
      ],
    );
  }
}
