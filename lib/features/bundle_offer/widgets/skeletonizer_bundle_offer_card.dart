import '../../../core/utils/app_imports.dart';

class SkeletonizerBundleOfferCard extends StatelessWidget {
  const SkeletonizerBundleOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColor.backgroundDark,
        highlightColor: AppColor.cardLight,
        duration: const Duration(milliseconds: 1200),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 35.h, left: 6.w, right: 6.w, bottom: 8.h),
        child: SizedBox(
          width: 220.w,
          height: 245.h,
          child: Container(
            width: 220.w,
            height: 245.h,
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.card,
                borderRadius: BorderRadius.circular(19.r),
                border: Border.all(
                  color: AppColor.border.withOpacity(.18),
                  width: 1.w,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.r),
                            bottomLeft: Radius.circular(15.r),
                          ),
                        ),
                        child: Icon(
                          Icons.info_outline,
                          color: AppColor.textOnDark,
                          size: 21.sp,
                        ),
                      ),
                    ],
                  ),

            SizedBox(height: 10.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: double.infinity,
                    height: 125.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.asset(
                      Assets.assets.images.customer.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    width: double.infinity,
                    height: 46.h,
                    child: Material(
                      color: AppColor.transparent,
                      borderRadius: BorderRadius.circular(23.r),
                      child: Ink(
                        padding: EdgeInsets.only(
                          right: 18.w,
                          left: 8.w,
                          top: 3.h,
                          bottom: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.card,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: AppColor.border.withOpacity(.35),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            // Title placeholder
                            Container(
                              width: 90.w,
                              height: 14.h,
                              decoration: BoxDecoration(
                                color: AppColor.backgroundDark,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),

                            // Cart button
                            Container(
                              width: 35.w,
                              height: 35.w,
                              decoration: BoxDecoration(
                                color: AppColor.backgroundDark,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.black.withOpacity(
                                      .18,
                                    ),
                                    blurRadius: 6.r,
                                    offset: Offset(0, 2.h),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
