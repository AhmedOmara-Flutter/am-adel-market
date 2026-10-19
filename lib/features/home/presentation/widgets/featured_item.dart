import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';
import 'available_featured_item.dart';
import 'paused_featured_item.dart';

class FeaturedItem extends StatelessWidget {
  final ProductEntity productEntity;

  const FeaturedItem({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    if (productEntity.isPaused) {
      return PausedFeaturedItem(productEntity: productEntity);
    }

    return AvailableFeaturedItem(productEntity: productEntity);
  }
}