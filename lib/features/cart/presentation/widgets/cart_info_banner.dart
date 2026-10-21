import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_imports.dart';

class CartInfoBanner extends StatelessWidget {
  final int productsInCart;

  const CartInfoBanner({
    super.key,
    required this.productsInCart,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasItems = productsInCart > 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Constants.screenHorizontal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: .08),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
          BoxShadow(
            color: AppColor.accentColor.withValues(alpha: hasItems ? .10 : .04),
            blurRadius: 12.r,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.white,
                AppColor.cardLight,
                AppColor.background,
              ],
            ),
          ),
          child: Stack(
            children: [
              // زخرفة باهتة في الركن
              PositionedDirectional(
                end: -28.r,
                bottom: -34.r,
                child: IgnorePointer(
                  child: Container(
                    width: 100.r,
                    height: 100.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.accentColor
                          .withValues(alpha: hasItems ? .08 : .04),
                    ),
                  ),
                ),
              ),

              // لمعة من فوق
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 36.h,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.white.withValues(alpha: .9),
                          AppColor.white.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),


              // المحتوى
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                child: Row(
                  children: [
                    _IconBadge(hasItems: hasItems),
                    SizedBox(width: 12.w),

                    // النصوص
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            hasItems ? 'سلة التسوق' : 'السلة فارغة',
                            style: StyleManager.font15Weight700.copyWith(
                              color: AppColor.textPrimary,
                              fontWeight: FontWeight.w800,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          const _BannerOrnament(),
                          SizedBox(height: 5.h),
                          Text(
                            hasItems
                                ? 'لديك $productsInCart منتجات جاهزة للطلب'
                                : 'لم تقم بإضافة أي منتجات بعد',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font12Weight500.copyWith(
                              color: AppColor.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10.w),

                    if (hasItems)
                      _CountPill(count: productsInCart)
                    else
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 14.sp,
                        color: AppColor.accentColor.withValues(alpha: .7),
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

/// أيقونة داخل مربع ذهبي ناعم (زي أيقونة الإجمالي في الكارت)
class _IconBadge extends StatelessWidget {
  final bool hasItems;

  const _IconBadge({required this.hasItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.r,
      height: 46.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: hasItems
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.goldLight.withValues(alpha: .55),
            AppColor.accentColor.withValues(alpha: .30),
          ],
        )
            : null,
        color: hasItems ? null : AppColor.goldLight.withValues(alpha: .18),
        border: Border.all(
          color: AppColor.accentColor.withValues(alpha: hasItems ? .55 : .30),
          width: 1,
        ),
      ),
      child: Icon(
        hasItems ? Icons.shopping_bag_rounded : Icons.shopping_cart_outlined,
        size: 23.sp,
        color: hasItems ? AppColor.mainColor : AppColor.textSecondary,
      ),
    );
  }
}

/// كبسولة العدد: خلفية داكنة + حد ذهبي + رقم ذهبي
class _CountPill extends StatelessWidget {
  final int count;

  const _CountPill({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColor.mainColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColor.goldLight.withValues(alpha: .8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: .25),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '$count',
            style: StyleManager.font15Weight700.copyWith(
              color: AppColor.goldLight,
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            'منتج',
            style: StyleManager.font11Weight400.copyWith(
              color: AppColor.textOnDark,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// فاصل زخرفي صغير: ◆ وخط ذهبي بيتلاشى
class _BannerOrnament extends StatelessWidget {
  const _BannerOrnament();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 5.r,
            height: 5.r,
            color: AppColor.accentColor,
          ),
        ),
        SizedBox(width: 5.w),
        Container(
          width: 30.w,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.accentColor.withValues(alpha: .6),
                AppColor.accentColor.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}