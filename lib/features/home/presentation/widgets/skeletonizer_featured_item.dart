import '../../../../core/utils/app_imports.dart';

class SkeletonizerFeaturedItem extends StatelessWidget {
  const SkeletonizerFeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColor.backgroundDark,
        highlightColor: AppColor.cardLight,
        duration: const Duration(milliseconds: 1200),
      ),
      child: GestureDetector(
        child: SizedBox(
          width: 112.w,
          height: 158.h,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 43.h,
                child: Container(
                  width: 110.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    color: AppColor.card,
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      color: AppColor.border.withOpacity(.18),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withOpacity(.18),
                        blurRadius: 22.r,
                        offset: Offset(0, 10.h),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 42.h,
                      left: 10.w,
                      right: 10.w,
                      bottom: 15.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'productEntity',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font14Weight600.copyWith(
                            color: AppColor.textOnDark,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.r),
                  child: SizedBox(
                    width: 90.w,
                    height: 90.w,
                    child: Image.asset(Assets.assets.images.amAdelLogo.path),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
