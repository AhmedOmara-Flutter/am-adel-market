import '../utils/app_imports.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;

  const CustomBackButton({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100.r),
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                color: AppColor.border,
                width: 1.w,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.assets.images.arrowBack.path,
                width: 15.w,
                height: 15.w,
                colorFilter: const ColorFilter.mode(
                  AppColor.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    )
    ;
  }
}