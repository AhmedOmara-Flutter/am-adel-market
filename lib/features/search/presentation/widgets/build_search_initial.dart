import 'dart:math' as math;
import '../../../../core/utils/app_imports.dart';

class BuildSearchInitial extends StatefulWidget {
  const BuildSearchInitial({super.key});

  @override
  State<BuildSearchInitial> createState() => _BuildSearchInitialState();
}

class _BuildSearchInitialState extends State<BuildSearchInitial>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbit = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  )..repeat();

  static const _foods = <IconData>[
    Icons.local_pizza_rounded,
    Icons.lunch_dining_rounded,
    Icons.ramen_dining_rounded,
    Icons.icecream_rounded,
    Icons.coffee_rounded,
  ];

  @override
  void dispose() {
    _orbit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = 300.w.clamp(240.0, 340.0);
    final radius = size * 0.383;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: RepaintBoundary(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, v, child) => Opacity(
              opacity: v,
              child: Transform.scale(scale: 0.92 + 0.08 * v, child: child),
            ),
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
                              AppColor.accentColor.withValues(alpha: 0.30),
                              AppColor.accentColor.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size * 0.77,
                        height: size * 0.77,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.border.withValues(alpha: 0.45),
                            width: 1.2,
                          ),
                        ),
                      ),
                      Container(
                        width: size * 0.5,
                        height: size * 0.5,
                        padding: EdgeInsets.all(size * 0.113),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.cardLight,
                          border: Border.all(
                            color: AppColor.accentColor,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.mainColor.withValues(alpha: 0.3),
                              blurRadius: 32,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          Assets.assets.images.searchImage.path,
                          fit: BoxFit.contain,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _orbit,
                        builder: (context, _) {
                          final base = _orbit.value * 2 * math.pi;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              for (int i = 0; i < _foods.length; i++)
                                Transform.translate(
                                  offset: Offset(
                                    radius *
                                        math.cos(
                                          base + i * 2 * math.pi / _foods.length,
                                        ),
                                    radius *
                                        math.sin(
                                          base + i * 2 * math.pi / _foods.length,
                                        ),
                                  ),
                                  child: _FoodBubble(icon: _foods[i]),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'ابحث عن أكلتك المفضلة',
                  style: StyleManager.font19Weight700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FoodBubble extends StatelessWidget {
  final IconData icon;
  const _FoodBubble({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColor.secondaryColor, AppColor.mainColor],
        ),
        border: Border.all(color: AppColor.goldLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(icon, size: 22.sp, color: AppColor.goldLight),
    );
  }
}