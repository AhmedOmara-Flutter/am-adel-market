import 'dart:math' as math;
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/app_skeleton_effect.dart';

class SkeletonizerProductItem extends StatelessWidget {
  const SkeletonizerProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final double radius = 26.r;

    return Skeletonizer(
      effect: AppSkeletonEffect.shimmer,
      child: LayoutBuilder(
        builder: (context, c) {
          final double w = c.maxWidth.isFinite ? c.maxWidth : 170.w;
          final double h = c.maxHeight.isFinite ? c.maxHeight : w * 1.25;

          final double plate = math.min(w * .68, h * .52);
          final double bodyTop = plate * .45;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // ===== جسم الكارت =====
              Positioned(
                top: bodyTop,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColor.white, AppColor.cardLight],
                    ),
                    border: Border.all(
                      color: AppColor.accentColor.withValues(alpha: .40),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.mainColor.withValues(alpha: .10),
                        blurRadius: 18.r,
                        offset: Offset(0, 9.h),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius - 1),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            12.w,
                            plate - bodyTop + 6.h,
                            12.w,
                            10.h,
                          ),
                          child: LayoutBuilder(
                            builder: (context, box) => FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                width: box.maxWidth,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'اسم المنتج هنا',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                      StyleManager.font14Weight600.copyWith(
                                        color: AppColor.textPrimary,
                                        fontWeight: FontWeight.w800,
                                        height: 1.25,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              '120 ج.م',
                                              style: StyleManager
                                                  .font14Weight600
                                                  .copyWith(
                                                color: AppColor.mainColor,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w900,
                                                height: 1.1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 40.r),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // تبويبة الإضافة
                        PositionedDirectional(
                          bottom: 0,
                          end: 0,
                          child: Container(
                            width: 50.r,
                            height: 46.r,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColor.goldLight,
                                  AppColor.accentColor,
                                ],
                              ),
                              borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(22.r),
                                bottomEnd: Radius.circular(radius),
                              ),
                            ),
                            child: Icon(
                              Icons.add_shopping_cart_rounded,
                              color: AppColor.mainColor,
                              size: 22.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ===== الطبق =====
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: plate,
                    height: plate,
                    padding: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColor.goldLight, AppColor.accentColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.mainColor.withValues(alpha: .18),
                          blurRadius: 20.r,
                          offset: Offset(0, 11.h),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.white,
                      ),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.backgroundDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ===== المفضلة =====
              PositionedDirectional(
                top: 2.h,
                end: 4.w,
                child: Container(
                  width: 34.r,
                  height: 34.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.accentColor.withValues(alpha: .35),
                    ),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 19.sp,
                    color: AppColor.textSecondary,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}