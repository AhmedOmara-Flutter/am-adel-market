import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/custom_back_button.dart';
import 'package:am_adel_market/core/widgets/resto_kit.dart';

/// هيدر الصفحة بطابع المنيو: العنوان في النص + فاصل ذهبي تحته،
/// وأزرار دايرية بإطار ذهبي.
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
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        top: topPadding.h,
        bottom: bottomPadding.h,
      ),
      child: SizedBox(
        height: 54.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // العنوان + الفاصل الزخرفي
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 62.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 21.sp,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(width: 90.w, child: const RestoDivider()),
                ],
              ),
            ),

            // زر الرجوع
            if (showBack)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: SizedBox(
                  width: 46.w,
                  height: 46.w,
                  child: const CustomBackButton(),
                ),
              ),

            // زر الإشعارات أو البحث
            if (showNotification || showSearch)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: _buildRightAction(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightAction() {
    if (showNotification) {
      return _ActionButton(
        icon: Icons.notifications_none_rounded,
        onTap: () {},
        showBadge: true,
      );
    }

    if (showSearch) {
      return _ActionButton(
        onTap: searchOnPressed,
        child: SvgPicture.asset(
          Assets.assets.images.search.path,
          width: 22.w,
          height: 22.w,
          colorFilter: const ColorFilter.mode(
            AppColor.mainColor,
            BlendMode.srcIn,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

// ============================================================
// زر البحث والإشعارات: حلقة ذهبية + قلب كريمي
// ============================================================
class _ActionButton extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onTap;
  final bool showBadge;

  const _ActionButton({
    this.icon,
    this.child,
    this.onTap,
    this.showBadge = false,
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
            onTap: onTap,
            customBorder: const CircleBorder(),
            splashColor: AppColor.accentColor.withValues(alpha: .18),
            highlightColor: AppColor.accentColor.withValues(alpha: .08),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (child != null)
                  child!
                else
                  Icon(icon, size: 25.sp, color: AppColor.mainColor),
                if (showBadge)
                  Positioned(
                    top: 9.h,
                    right: 10.w,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.cardLight,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}