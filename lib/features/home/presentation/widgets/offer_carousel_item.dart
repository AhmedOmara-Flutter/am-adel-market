import 'package:cached_network_image/cached_network_image.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/entities/offer_entity.dart';

class OfferCarouselItem extends StatelessWidget {
  final OfferEntity offer;

  const OfferCarouselItem({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteManager.productDetails,
            arguments: offer.productId,
          );
        },
        child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.r),
              child: Stack(
                children: [
              Positioned.fill(
              child: CachedNetworkImage(
              imageUrl: offer.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColor.card,
                  highlightColor: AppColor.border,
                  child: Container(
                    color: AppColor.card,
                  ),
                ),
                errorWidget: (context, url, error) => Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.card,
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          color: AppColor.textSecondary,
                          size: 34.sp,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "تعذر تحميل الصورة",
                          style: StyleManager.font12Weight500.copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(.55),
                      Colors.black.withOpacity(.38),
                      Colors.black.withOpacity(.18),
                      Colors.transparent,
                    ],
                    stops: const [
                      0.0,
                      .45,
                      .80,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),

                  Padding(
                    padding: EdgeInsets.all(18.w),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // =================================================
                                // DISCOUNT
                                // =================================================
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 7.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    borderRadius: BorderRadius.circular(30.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.mainColor.withOpacity(.25),
                                        blurRadius: 10.r,
                                        offset: Offset(
                                          0,
                                          4.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.local_offer_rounded,
                                        color: Colors.white,
                                        size: 14.sp,
                                      ),

                                      SizedBox(width: 5.w),

                                      Text(
                                        "خصم ${offer.discountPercentage}%",
                                        style: StyleManager.font11Weight400.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: .3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // =================================================
                                // OFFER INFO
                                // =================================================
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.card.withOpacity(.75),
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        offer.name,
                                        style: StyleManager.font18Weight700.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),

                                      SizedBox(height: 6.h),

                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${offer.priceAfterDiscount} ج.م",
                                            style: StyleManager.font19Weight700.copyWith(
                                              color: AppColor.mainColor,
                                            ),
                                          ),

                                          SizedBox(width: 8.w),

                                          Text(
                                            "${offer.priceBeforeDiscount} ج.م",
                                            style: StyleManager.font13Weight400.copyWith(
                                              color: AppColor.textSecondary,
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: AppColor.textSecondary,
                                              decorationThickness: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // =================================================
                                // ORDER BUTTON
                                // =================================================
                                InkWell(
                                  borderRadius: BorderRadius.circular(30.r),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteManager.productDetails,
                                      arguments: offer.productId,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18.w,
                                      vertical: 11.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      borderRadius: BorderRadius.circular(30.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.mainColor.withOpacity(.35),
                                          blurRadius: 12.r,
                                          offset: Offset(
                                            0,
                                            6.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "اطلب الآن",
                                          style: StyleManager.font14Weight600.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),

                                        SizedBox(width: 8.w),

                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                          size: 18.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}