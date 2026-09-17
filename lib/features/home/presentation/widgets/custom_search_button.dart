
import '../../../../core/utils/app_imports.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = AppColor.cardLight;

    return SizedBox(
      width: 60.w,
      height: 60.w,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,

          // Background
          color: buttonColor,

          // Border
          border: Border.all(
            color: AppColor.border.withOpacity(0.45),
            width: 1.w,
          ),

          // Shadow
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withOpacity(0.08),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),

        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),

          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.search,
              );
            },

            customBorder: const CircleBorder(),

            splashColor: AppColor.accentColor.withOpacity(0.18),
            highlightColor: AppColor.accentColor.withOpacity(0.08),

            child: Center(
              child: SvgPicture.asset(
                Assets.assets.images.search.path,
                width: 24.w,
                height: 24.w,
                colorFilter: const ColorFilter.mode(
                  AppColor.mainColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}