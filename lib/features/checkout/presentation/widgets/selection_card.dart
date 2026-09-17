import '../../../../core/utils/app_imports.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.isSelected,
    required this.item,
    this.onTap,
  });

  final VoidCallback? onTap;
  final bool isSelected;
  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.mainColor.withOpacity(.055)
              : AppColor.cardLight,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected
                ? AppColor.mainColor.withOpacity(.65)
                : AppColor.border.withOpacity(.35),
            width: isSelected ? 1.3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColor.mainColor.withOpacity(.10)
                  : AppColor.black.withOpacity(.035),
              blurRadius: isSelected ? 14 : 8,
              offset: Offset(0, isSelected ? 5.h : 3.h),
            ),
          ],
        ),
        child: Row(
          children: [
            // Selection indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColor.mainColor : AppColor.transparent,
                border: Border.all(
                  color: isSelected ? AppColor.mainColor : AppColor.border,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColor.mainColor.withOpacity(.18),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        key: const ValueKey('selected'),
                        color: AppColor.textOnDark,
                        size: 15.sp,
                      )
                    : const SizedBox(key: ValueKey('unselected')),
              ),
            ),

            SizedBox(width: 13.w),

            // Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item["title"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font14Weight600.copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    item["subtitle"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font11Weight400.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // Price
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: StyleManager.font15Weight700.copyWith(
                color: isSelected
                    ? AppColor.mainColor
                    : AppColor.secondaryColor,
              ),
              child: Text(item["price"]!, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}
