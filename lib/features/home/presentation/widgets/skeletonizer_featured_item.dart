import 'package:am_adel_market/core/widgets/app_skeleton_effect.dart';
import 'package:am_adel_market/core/widgets/resto_kit.dart';

import '../../../../core/utils/app_imports.dart';

class SkeletonizerFeaturedItem extends StatelessWidget {
  const SkeletonizerFeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    final double plateSize = 82.r;

    return Skeletonizer(
      effect: AppSkeletonEffect.shimmer,
      child: SizedBox(
        width: 112.w,
        height: 158.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 48.h,
              child: SizedBox(
                width: 110.w,
                height: 102.h,
                child: RestoFrame(
                  radius: 26,
                  padding: EdgeInsets.only(
                    top: 38.h,
                    left: 8.w,
                    right: 8.w,
                    bottom: 14.h,
                  ),
                  child: Center(
                    child: Text(
                      'productEntity',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font14Weight600.copyWith(
                        color: AppColor.textPrimary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 6.h,
              child: Container(
                width: plateSize,
                height: plateSize,
                padding: EdgeInsets.all(2.5.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: Resto.gold,
                  boxShadow: Resto.shadow(alpha: .12, blur: 12, dy: 5),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.backgroundDark,
                  ),
                ),
              ),
            ),

            // ===== زرار "اطلب الآن" =====
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: Resto.gold,
                  border: Border.all(color: AppColor.white, width: 2),
                ),
                child: Text(
                  'اطلب الآن',
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}