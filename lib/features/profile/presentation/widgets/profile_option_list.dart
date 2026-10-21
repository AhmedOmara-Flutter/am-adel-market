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
      child: InkWell(
        onTap: isButton ? null : onTap,
        splashColor: AppColor.accentColor.withValues(alpha: .12),
        highlightColor: AppColor.accentColor.withValues(alpha: .05),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
          child: Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: AppColor.accentColor.withValues(alpha: .16),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, size: 20.sp, color: AppColor.secondaryColor),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font15Weight700.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ),
              if (isButton)
                const ToggleButton()
              else
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: AppColor.border,
                ),
            ],
          ),
        ),
      ),
    );
  }
}