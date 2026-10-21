import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/resto_kit.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      padding: EdgeInsets.all(1.6.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: Resto.gold,
        boxShadow: Resto.shadow(alpha: .10, blur: 9, dy: 3),
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.cardLight,
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.search,
              );
            },
            customBorder: const CircleBorder(),
            splashColor: AppColor.accentColor.withValues(alpha: .18),
            highlightColor: AppColor.accentColor.withValues(alpha: .08),
            child: Center(
              child: SvgPicture.asset(
                Assets.assets.images.search.path,
                width: 22.w,
                height: 22.w,
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

