import 'package:am_adel_market/core/utils/app_imports.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: double.infinity,
        height: 58.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),

            // ==============================
            // Background
            // ==============================
            color: isDisabled
                ? AppColor.backgroundDark
                : color ?? AppColor.mainColor,

            // ==============================
            // Shadow
            // ==============================
            boxShadow: isDisabled
                ? []
                : [
              BoxShadow(
                color: AppColor.mainColor.withOpacity(0.22),
                blurRadius: 14.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),

          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),

            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(18.r),

              splashColor: AppColor.accentColor.withOpacity(0.18),
              highlightColor: AppColor.accentColor.withOpacity(0.08),

              child: Center(
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: isDisabled
                        ? AppColor.textSecondary.withOpacity(0.5)
                        : AppColor.textOnDark,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

