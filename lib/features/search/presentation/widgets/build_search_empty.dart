import '../../../../core/utils/app_imports.dart';

class BuildSearchEmpty extends StatelessWidget {
  final String? query;
  const BuildSearchEmpty({super.key, this.query});

  @override
  Widget build(BuildContext context) {
    final q = query?.trim() ?? '';
    final size = 220.w.clamp(190.0, 260.0);

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: RepaintBoundary(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutBack,
            builder: (context, v, child) => Opacity(
              opacity: v.clamp(0.0, 1.0),
              child: Transform.scale(scale: 0.85 + 0.15 * v, child: child),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size,
                    height: size,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColor.accentColor.withValues(alpha: 0.28),
                                AppColor.accentColor.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size * 0.73,
                          height: size * 0.73,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.border.withValues(alpha: 0.45),
                              width: 1.2,
                            ),
                          ),
                        ),
                        Container(
                          width: size * 0.51,
                          height: size * 0.51,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                AppColor.secondaryColor,
                                AppColor.bottomNav,
                              ],
                            ),
                            border: Border.all(
                              color: AppColor.goldLight,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.mainColor.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 28,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.no_meals_rounded,
                            size: 52.sp,
                            color: AppColor.goldLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text('مفيش نتايج', style: StyleManager.font19Weight700),
                  if (q.isNotEmpty) ...[
                    SizedBox(height: 14.h),
                    Container(
                      constraints: BoxConstraints(maxWidth: 260.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 9.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.cardLight,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: AppColor.border.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            size: 18.sp,
                            color: AppColor.accentColor,
                          ),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              q,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font14Weight600.copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}