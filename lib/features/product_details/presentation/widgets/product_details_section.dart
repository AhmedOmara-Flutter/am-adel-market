import '../../../../core/entities/offer_entity.dart';
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
                          color: AppColor.white,
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
            SizedBox(height: 10.h),
            RatingAndReviews(product: product),
            SizedBox(height: 15.h),
            Text(
              product.description,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: const Color(0xff979899),
                fontSize: 13.sp,
                height: 1.4,
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
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10.r),
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
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12.sp,
                  ),
                ),
              Text(
                hasOffer
                    ? '${offer.priceAfterDiscount} جنيه'
                    : '${product.price} جنيه',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: const Color(0xffF4A91F),
                  fontSize: 13.sp,
                ),
              ),
              if (hasOffer)
                Text(
                  offer.remainingDays > 0
                      ? 'باقي ${offer.remainingDays} أيام'
                      : 'ينتهي اليوم',
                  style: StyleManager.font11Weight400.copyWith(
                    color: Colors.red.shade400,
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
                color: Colors.red,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '-${offer.discountPercentage.toInt()}%',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}