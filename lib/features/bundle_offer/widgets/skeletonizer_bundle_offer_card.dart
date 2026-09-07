import '../../../core/utils/app_imports.dart';

class SkeletonizerBundleOfferCard extends StatelessWidget {
  const SkeletonizerBundleOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 35.h,
        left: 6.w,
        right: 6.w,
        bottom: 8.h,
      ),
      child: SizedBox(
        width: 220.w,
        height: 245.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
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
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withOpacity(.30),
                        blurRadius: 10.r,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // =================================================
                      // INFO BUTTON
                      // =================================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 34.w,
                            height: 34.h,
                            decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.r),
                                bottomLeft: Radius.circular(15.r),
                              ),
                            ),
                            child: Icon(
                              Icons.info_outline,
                              color: AppColor.white,
                              size: 21.sp,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // =================================================
                      // IMAGE PLACEHOLDER
                      // =================================================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          width: double.infinity,
                          height: 125.h,
                          decoration: BoxDecoration(
                            color: AppColor.background,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            size: 40.sp,
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // =================================================
                      // BUTTON
                      // =================================================
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
                                color: AppColor.border,
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
                                    color: AppColor.border,
                                    borderRadius:
                                    BorderRadius.circular(6.r),
                                  ),
                                ),

                                // Cart button
                                Container(
                                  width: 35.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.mainColor
                                            .withOpacity(.20),
                                        blurRadius: 6.r,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    color: AppColor.white,
                                    size: 18.sp,
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

            // =============================================================
            // PRICE BADGE PLACEHOLDER
            // =============================================================
            Positioned(
              top: -25.h,
              left: -10.w,
              child: SizedBox(
                width: 105.w,
                height: 70.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      Assets.assets.images.crepe.path,
                      fit: BoxFit.contain,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: AppColor.border,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          width: 35.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: AppColor.border,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}