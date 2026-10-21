import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/resto_kit.dart';

import '../../../../core/widgets/app_skeleton_effect.dart';

/// سكيلتون كارت العرض: كريمي فاتح بإطار ذهبي،
/// عشان يطابق ألوان التطبيق ويبان خفيف وقت التحميل.
class SkeletonizerOfferItem extends StatelessWidget {
  const SkeletonizerOfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: AppSkeletonEffect.shimmer,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 180.h,
        child: RestoFrame(
          radius: 22,
          child: Stack(
            children: [
              // زخرفة خفيفة
              Positioned(
                top: -25.h,
                right: -25.w,
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    color: AppColor.accentColor.withValues(alpha: .10),
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
                    color: AppColor.goldLight.withValues(alpha: .18),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    // ===== النصوص =====
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // شارة الخصم
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: Resto.gold,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_offer_rounded,
                                  color: AppColor.mainColor,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "خصم 20%",
                                  style: StyleManager.font11Weight400.copyWith(
                                    color: AppColor.mainColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 12.h),

                          // الاسم والسعر
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 9.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.backgroundDark.withValues(
                                alpha: .55,
                              ),
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: AppColor.divider.withValues(alpha: .6),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'offer.name',
                                  style: StyleManager.font18Weight700.copyWith(
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "1966 ج.م",
                                      style: StyleManager.font19Weight700
                                          .copyWith(color: AppColor.mainColor),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "2555 ج.م",
                                      style: StyleManager.font13Weight400
                                          .copyWith(
                                        color: AppColor.textSecondary,
                                        decoration:
                                        TextDecoration.lineThrough,
                                        decorationColor:
                                        AppColor.textSecondary,
                                        decorationThickness: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // زرار اطلب الآن
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 9.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: Resto.gold,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color: AppColor.white,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "اطلب الآن",
                                  style: StyleManager.font14Weight600.copyWith(
                                    color: AppColor.mainColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: AppColor.mainColor,
                                  size: 18.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // ===== الطبق =====
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Container(
                          width: 96.w,
                          height: 96.w,
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: Resto.gold,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.backgroundDark,
                            ),
                          ),
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