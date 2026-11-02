import '../../../offers/domain/entities/offer_entity.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';
import 'rating_and_reviews.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({
    super.key,
    required this.product,
    required this.offer,
  });

  final ProductEntity product;
  final OfferEntity? offer;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: StyleManager.font16Weight700.copyWith(
                          color: AppColor.card,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '${product.price} ج.م',
                        style: StyleManager.font16Weight600.copyWith(
                          color: AppColor.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (offer != null && offer!.isActive)
                  buildSimplePrice(
                    context: context,
                    offer: offer,
                    product: product,
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            RatingAndReviews(product: product),
            SizedBox(height: 16.h),
            Text(
              product.description,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColor.textSecondary,
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSimplePrice({
    required BuildContext context,
    required OfferEntity? offer,
    required ProductEntity product,
  }) {
    final hasOffer = offer != null && offer.isActive;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.border.withOpacity(0.45), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasOffer)
                Text(
                  '${offer.priceBeforeDiscount} جنيه',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColor.textSecondary,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColor.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),

              Text(
                hasOffer
                    ? '${offer.priceAfterDiscount} جنيه'
                    : '${product.price} جنيه',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColor.mainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              if (hasOffer)
                Text(
                  offer.remainingDays > 0
                      ? 'باقي ${offer.remainingDays} أيام'
                      : 'ينتهي اليوم',
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.red,
                    fontSize: 11.sp,
                  ),
                ),
            ],
          ),

          SizedBox(width: 15.w),

          if (hasOffer)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColor.red,
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Text(
                '-${offer.discountPercentage.toInt()}%',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColor.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
