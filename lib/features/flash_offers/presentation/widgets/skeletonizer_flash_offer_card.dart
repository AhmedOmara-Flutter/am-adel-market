
import '../../../../core/utils/app_imports.dart';

class SkeletonizerFlashOfferCard extends StatelessWidget {
  const SkeletonizerFlashOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColor.backgroundDark,
        highlightColor: AppColor.cardLight,
        duration: const Duration(milliseconds: 1200),
      ),
      child: Container(
        width: double.infinity,
        height: 190.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}