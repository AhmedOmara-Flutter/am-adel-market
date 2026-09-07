import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

class SkeletonizerOfferItem extends StatelessWidget {
  const SkeletonizerOfferItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: const Color(0xff2B2B2B),
        highlightColor: const Color(0xff404040),
        duration: const Duration(milliseconds: 1200),
      ),
        child: GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              height: 180.h,
              decoration: BoxDecoration(
                color: AppColor.card,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: AppColor.border,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.r),
                child: Stack(
                    children: [
                Positioned.fill(
                child: Container(
                color: const Color(0xff2D2D2D),
              ),
            ),

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
                    color: const Color(0xff383838),
                    borderRadius:
                    BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_offer_rounded,
                        color: Colors.white70,
                        size: 14.sp,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "خصم 20%",
                        style: StyleManager.font11Weight400
                            .copyWith(
                          color: Colors.white70,
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
                      color: const Color(0xff303030),
                      borderRadius:
                      BorderRadius.circular(14.r),
                    ),
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'offer.name',
                          style: StyleManager.font18Weight700.copyWith(
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 6.h),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "1966 ج.م",
                              style: StyleManager.font19Weight700.copyWith(
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(width: 8.w),

                            Text(
                              "2555 ج.م",
                              style: StyleManager.font13Weight400.copyWith(
                                color: Colors.white54,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white54,
                                decorationThickness: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),),

                  const Spacer(),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 11.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff383838),
                      borderRadius: BorderRadius.circular(30.r),
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
                ]
            ) )
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
                    color: Colors.white.withOpacity(.03),
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
                    color: Colors.white.withOpacity(.02),
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