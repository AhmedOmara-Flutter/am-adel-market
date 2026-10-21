import 'package:am_adel_market/core/widgets/resto_kit.dart';

import '../utils/app_imports.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;

  const CustomBackButton({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.w,
      height: 46.w,
      padding: EdgeInsets.all(1.6.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: Resto.gold,
        boxShadow: Resto.shadow(
          alpha: .10,
          blur: 9,
          dy: 3,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? AppColor.cardLight,
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            customBorder: const CircleBorder(),
            splashColor: AppColor.accentColor.withValues(alpha: .18),
            highlightColor: AppColor.accentColor.withValues(alpha: .08),
            child: Center(
              child: SvgPicture.asset(
                Assets.assets.images.arrowBack.path,
                width: 16.w,
                height: 16.w,
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