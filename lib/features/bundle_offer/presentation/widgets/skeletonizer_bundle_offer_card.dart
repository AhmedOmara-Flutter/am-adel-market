import 'package:am_adel_market/core/widgets/app_skeleton_effect.dart';

import '../../../../core/utils/app_imports.dart';


class SkeletonizerBundleOfferCard extends StatelessWidget {
  const SkeletonizerBundleOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: AppSkeletonEffect.shimmer,
      child: Container(
        width: 310.w,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColor.divider.withValues(alpha: .25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withValues(alpha: 0.10),
              blurRadius: 14.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة العرض
                Container(
                  width: 112.w,
                  height: 122.h,
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.goldLight,
                        AppColor.accentColor,
                        AppColor.border,
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: const SizedBox.expand(
                      child: ColoredBox(color: AppColor.backgroundDark),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // تفاصيل العرض
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.accentColor.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: Text(
                          'عرض كومبو',
                          style: StyleManager.font12Weight500.copyWith(
                            color: AppColor.secondaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'اسم الكومبو يظهر هنا',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Weight600.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w800,
                          height: 1.35,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'وصف الكومبو يظهر هنا وفيه تفاصيل المحتويات',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 11.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // فاصل ذهبي
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColor.divider.withValues(alpha: 0.7),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 15.sp,
                    color: AppColor.accentColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColor.divider.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // السعر والزرار
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'سعر العرض',
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '199',
                            style: StyleManager.font23Weight700.copyWith(
                              color: AppColor.mainColor,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'ج.م',
                            style: StyleManager.font12Weight500.copyWith(
                              color: AppColor.secondaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  flex: 2,
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsetsDirectional.only(start: 14.w, end: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColor.goldLight, AppColor.accentColor],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'أضف إلى السلة',
                          style: StyleManager.font14Weight600.copyWith(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          width: 32.r,
                          height: 32.r,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: AppColor.mainColor,
                            size: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}