import 'package:cached_network_image/cached_network_image.dart';
import 'package:am_adel_market/features/product_details/presentation/widgets/discount_bedge.dart';
import '../../../../core/entities/offer_entity.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/custom_back_button.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    super.key,
    required this.product,
    required this.offer,
  });

  final ProductEntity product;
  final OfferEntity? offer;

  @override
  Widget build(BuildContext context) {
    final localOffer = offer;
    final hasOffer = localOffer?.isActive ?? false;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 0.44.sh,
        child: Stack(
          children: [
            SvgPicture.asset(
              Assets.assets.images.productDetailsBg.path,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),

            Center(
              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                height: 222.h,
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(
                  child: Skeletonizer(
                    child: SizedBox(
                      width: 222.w,
                      height: 222.h,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50.sp,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 40.h,
              right: 10.w,
              child: const CustomBackButton(
                color: Colors.white,
              ),
            ),

            if (hasOffer)
              Positioned(
                top: 50.h,
                left: -8.w,
                child: DiscountBadge(
                  percent: localOffer!.discountPercentage,
                ),
              ),
          ],
        ),
      ),
    );
  }
}