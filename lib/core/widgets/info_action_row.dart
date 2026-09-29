import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/custom_back_button.dart';

class InfoActionRow extends StatelessWidget {
  final String text;
  final bool showBack;
  final bool showNotification;
  final bool showSearch;
  final double bottomPadding;
  final double topPadding;
  final VoidCallback? searchOnPressed;

  const InfoActionRow({
    super.key,
    required this.text,
    this.showBack = false,
    this.showNotification = false,
    this.showSearch = false,
    this.bottomPadding = 20,
    this.topPadding = 40,
    this.searchOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: topPadding.h,
        bottom: bottomPadding.h,
      ),
      child: Row(
        children: [
          // ==========================================
          // Back
          // ==========================================
          SizedBox(
            height: 60.w,
            width: 60.w,
            child: showBack
                ? const CustomBackButton()
                : const SizedBox(),
          ),

          // ==========================================
          // Title
          // ==========================================
          Expanded(
            child: Center(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: textTheme.displaySmall?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          // ==========================================
          // Right Action
          // ==========================================
          SizedBox(
            height: 60.w,
            width: 60.w,
            child: _buildRightAction(),
          ),
        ],
      ),
    );
  }

  Widget _buildRightAction() {
    // ==========================================
    // Notification
    // ==========================================
    if (showNotification) {
      return Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.border.withOpacity(0.55),
            width: 1.w,
          ),
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
            onTap: () {},
            customBorder: const CircleBorder(),
            splashColor: AppColor.accentColor.withOpacity(0.15),
            highlightColor: AppColor.accentColor.withOpacity(0.07),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 29.sp,
                  color: AppColor.mainColor,
                ),

                Positioned(
                  top: 13.h,
                  right: 16.w,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppColor.accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.cardLight,
                        width: 1.5.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ==========================================
    // Search
    // ==========================================
    if (showSearch) {
      return Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.border.withOpacity(0.55),
            width: 1.w,
          ),
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
            borderRadius: BorderRadius.circular(100.r),
            onTap: searchOnPressed,
            splashColor: AppColor.accentColor.withOpacity(0.15),
            highlightColor: AppColor.accentColor.withOpacity(0.07),
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
      );
    }

    return const SizedBox();
  }
}
