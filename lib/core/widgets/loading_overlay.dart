import 'dart:ui';

import 'package:am_adel_market/core/utils/app_imports.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final String title;
  final String? subtitle;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    this.title = 'جاري التحميل...',
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;

    return Positioned.fill(
      child: AbsorbPointer(
        absorbing: true,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Container(
            color: AppColor.mainColor.withOpacity(0.18),

            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 190.w,
                  maxWidth: 240.w,
                ),

                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 26.h,
                ),

                decoration: BoxDecoration(
                  // ==========================================
                  // Card
                  // ==========================================
                  color: AppColor.cardLight,

                  borderRadius: BorderRadius.circular(22.r),

                  // ==========================================
                  // Border
                  // ==========================================
                  border: Border.all(
                    color: AppColor.border.withOpacity(0.45),
                    width: 1.w,
                  ),

                  // ==========================================
                  // Shadow
                  // ==========================================
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.mainColor.withOpacity(0.18),
                      blurRadius: 24.r,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ==========================================
                    // Loading Indicator
                    // ==========================================
                    SizedBox(
                      width: 44.w,
                      height: 44.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.2.w,
                        color: AppColor.mainColor,
                        backgroundColor:
                        AppColor.accentColor.withOpacity(0.18),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // ==========================================
                    // Title
                    // ==========================================
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColor.textPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    // ==========================================
                    // Subtitle
                    // ==========================================
                    if (subtitle != null) ...[
                      SizedBox(height: 7.h),

                      Text(
                        subtitle!,
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
