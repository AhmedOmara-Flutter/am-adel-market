import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/app_skeleton_effect.dart';

class SkeletonizerFlashOfferCard extends StatelessWidget {
  const SkeletonizerFlashOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: AppSkeletonEffect.shimmer,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColor.accentColor.withOpacity(0.3)
          )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            Assets.assets.images.me.path,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}