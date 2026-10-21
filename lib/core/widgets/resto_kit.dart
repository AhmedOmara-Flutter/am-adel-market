import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

String restoFmt(num v) => v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(2);

class Resto {
  Resto._();

  static const LinearGradient gold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColor.goldLight, AppColor.accentColor],
  );

  static List<BoxShadow> shadow({
    double alpha = .12,
    double blur = 16,
    double dy = 8,
  }) =>
      [
        BoxShadow(
          color: AppColor.mainColor.withValues(alpha: alpha),
          blurRadius: blur.r,
          offset: Offset(0, dy.h),
        ),
      ];
}

// ------------------------------------------------------------
//  إطار المنيو: حد ذهبي خارجي + خط رفيع جوّا
// ------------------------------------------------------------
class RestoFrame extends StatelessWidget {
  final Widget child;
  final double radius;
  final bool muted;
  final EdgeInsetsGeometry padding;

  const RestoFrame({
    super.key,
    required this.child,
    this.radius = 22,
    this.muted = false,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final double r = radius.r;
    final double gap = 4.r;

    return Container(
      padding: EdgeInsets.all(gap),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(r),
        border: Border.all(
          color:AppColor.divider.withOpacity(.25),
          width: 1.2,
        ),
        boxShadow: Resto.shadow(alpha: muted ? .04 : .12),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r - gap),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.white, AppColor.cardLight],
          ),
          // border: Border.all(
          //   color: AppColor.accentColor.withValues(alpha: muted ? .12 : .30),
          //   width: 1,
          // ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(r - gap - 1),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
//  صورة الأكل (مع placeholder و fallback)
// ------------------------------------------------------------
class RestoImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double iconSize;

  const RestoImage({super.key, required this.url, this.width, this.iconSize = 40});

  @override
  Widget build(BuildContext context) {
    final String? u = url?.trim();
    if (u == null || u.isEmpty) return _fallback();

    final int? cacheWidth = width == null
        ? null
        : (width! * MediaQuery.devicePixelRatioOf(context)).round();

    return CachedNetworkImage(
      imageUrl: u,
      fit: BoxFit.cover,
      memCacheWidth: cacheWidth,
      fadeInDuration: const Duration(milliseconds: 250),
      placeholder: (_, __) => Container(
        color: AppColor.backgroundDark,
        alignment: Alignment.center,
        child: SizedBox(
          width: 22.r,
          height: 22.r,
          child: const CircularProgressIndicator(
            color: AppColor.accentColor,
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (_, __, ___) => _fallback(),
    );
  }

  Widget _fallback() => Container(
    color: AppColor.backgroundDark,
    alignment: Alignment.center,
    child: Icon(
      Icons.restaurant_rounded,
      size: iconSize.sp,
      color: AppColor.secondaryColor,
    ),
  );
}

// ------------------------------------------------------------
//  فاصل زخرفي: ─── ◆ ───
// ------------------------------------------------------------
class RestoDivider extends StatelessWidget {
  final bool compact;

  const RestoDivider({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    Widget line(bool reverse) => Expanded(
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: reverse ? Alignment.centerRight : Alignment.centerLeft,
            end: reverse ? Alignment.centerLeft : Alignment.centerRight,
            colors: [
              AppColor.accentColor.withValues(alpha: 0),
              AppColor.accentColor.withValues(alpha: .7),
            ],
          ),
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        line(false),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: compact ? 4.w : 7.w),
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: compact ? 5.r : 6.r,
              height: compact ? 5.r : 6.r,
              color: AppColor.accentColor,
            ),
          ),
        ),
        line(true),
      ],
    );
  }
}

// ------------------------------------------------------------
//  نقط التوصيل بين الاسم والسعر (زي المنيو)
// ------------------------------------------------------------
class RestoDottedLeader extends StatelessWidget {
  const RestoDottedLeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final int n = c.maxWidth.isFinite ? (c.maxWidth / 6).floor() : 8;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            math.max(n, 0),
                (_) => Container(
              width: 2.r,
              height: 2.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.accentColor.withValues(alpha: .7),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ------------------------------------------------------------
//  السعر: رقم كبير + "ج.م" صغيرة
// ------------------------------------------------------------
class RestoPrice extends StatelessWidget {
  final num value;
  final double size;

  const RestoPrice({super.key, required this.value, this.size = 17});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: restoFmt(value),
            style: StyleManager.font14Weight600.copyWith(
              color: AppColor.mainColor,
              fontSize: size.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          TextSpan(
            text: ' ج.م',
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.secondaryColor,
              fontSize: (size * .62).sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
//  شارة ذهبية (خصم / عرض كومبو ...)
// ------------------------------------------------------------
class RestoBadge extends StatelessWidget {
  final String text;
  final IconData? icon;
  final BorderRadiusGeometry? borderRadius;

  const RestoBadge({super.key, required this.text, this.icon, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(20.r),
        gradient: Resto.gold,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12.sp, color: AppColor.mainColor),
            SizedBox(width: 3.w),
          ],
          Text(
            text,
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.mainColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
//  زرار دايري (ذهبي أو أبيض) بإطار أبيض
// ------------------------------------------------------------
class RestoCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final bool gold;
  final Color? iconColor;

  const RestoCircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 40,
    this.gold = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gold ? Resto.gold : null,
          color: gold ? null : AppColor.white.withValues(alpha: .95),
          border: Border.all(color: AppColor.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: gold
                  ? AppColor.accentColor.withValues(alpha: .55)
                  : Colors.black.withValues(alpha: .18),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: (size * .5).sp,
          color: iconColor ?? AppColor.mainColor,
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
//  ضغطة بتصغّر الكارت شوية
// ------------------------------------------------------------
class RestoPressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double pressedScale;

  const RestoPressScale({
    super.key,
    required this.child,
    required this.onTap,
    this.pressedScale = .97,
  });

  @override
  State<RestoPressScale> createState() => _RestoPressScaleState();
}

class _RestoPressScaleState extends State<RestoPressScale> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed == v) return;
    setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}