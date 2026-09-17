import 'package:am_adel_market/core/utils/app_imports.dart';

class SkeletonizerOfferItem extends StatelessWidget {
  const SkeletonizerOfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColor.backgroundDark,
        highlightColor: AppColor.cardLight,
        duration: const Duration(milliseconds: 1200),
      ),
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          height: 180.h,
          decoration: BoxDecoration(
            color: AppColor.card,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: AppColor.border.withOpacity(.18),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withOpacity(.18),
                blurRadius: 22.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22.r),
            child: Stack(
              children: [
                Positioned.fill(child: Container(color: AppColor.card)),

                Padding(
                  padding: EdgeInsets.all(18.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 7.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.backgroundDark,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.local_offer_rounded,
                                    color: AppColor.textOnDark,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "خصم 20%",
                                    style: StyleManager.font11Weight400
                                        .copyWith(
                                          color: AppColor.textOnDark,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: .3,
                                        ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 14.h),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.card,
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'offer.name',
                                    style: StyleManager.font18Weight700
                                        .copyWith(color: AppColor.textOnDark),
                                  ),

                                  SizedBox(height: 6.h),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "1966 ج.م",
                                        style: StyleManager.font19Weight700
                                            .copyWith(
                                              color: AppColor.textOnDark,
                                            ),
                                      ),

                                      SizedBox(width: 8.w),

                                      Text(
                                        "2555 ج.م",
                                        style: StyleManager.font13Weight400
                                            .copyWith(
                                              color: AppColor.backgroundDark,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor:
                                                  AppColor.backgroundDark,
                                              decorationThickness: 1.4,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 11.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.backgroundDark,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "اطلب الآن",
                                    style: StyleManager.font14Weight600
                                        .copyWith(color: AppColor.textOnDark),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: AppColor.textOnDark,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: -25.h,
                  right: -25.w,
                  child: Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundDark.withOpacity(.18),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                Positioned(
                  bottom: -30.h,
                  left: -30.w,
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundDark.withOpacity(.12),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
