import 'package:am_adel_market/features/profile/presentation/widgets/toggle_button.dart';
import '../../../../core/utils/app_imports.dart';

class ProfileOptionsList extends StatelessWidget {
  final bool isButton;
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileOptionsList({
    super.key,
    this.isButton = false,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColor.border.withOpacity(.6),
                width: 1.w,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(icon, size: 20.sp, color: AppColor.mainColor),
                ),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Text(
                  text,
                  style: StyleManager.font13Weight600.copyWith(
                    color: AppColor.textPrimary
                  )
                ),
              ),

              if (isButton)
                const ToggleButton()
              else
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 17.sp,
                  color: AppColor.textSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}