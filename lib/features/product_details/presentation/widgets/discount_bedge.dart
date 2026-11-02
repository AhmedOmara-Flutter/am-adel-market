import 'dart:math' as math;

import '../../../../core/utils/app_imports.dart';

/// بادج خصم على شكل "تيكيت" ذهبي معلّق بخيط، بيتأرجح بهدوء
/// ولمعة بتعدّي عليه كل كام ثانية. الألوان كلها من AppColor.
class DiscountBadge extends StatefulWidget {
  final double percent;
  final double? size;

  const DiscountBadge({
    super.key,
    required this.percent,
    this.size,
  });

  @override
  State<DiscountBadge> createState() => _DiscountBadgeState();
}

class _DiscountBadgeState extends State<DiscountBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.size ?? 56.w;
    final tagH = w * 1.32;
    final stringH = w * 0.42;
    final c = w * 0.26; // قطع الزوايا العلوية

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final angle = math.sin(t * 2 * math.pi) * 0.09;
        final shine = ((t - 0.55) / 0.35).clamp(0.0, 1.0);

        return Transform.rotate(
          angle: angle,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: w,
            height: stringH + tagH,
            child: CustomPaint(
              painter: _TagPainter(
                tagH: tagH,
                stringH: stringH,
                chamfer: c,
                shine: shine,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: stringH + c * 1.55,
                    bottom: tagH * 0.07,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: w * 0.12,
                                vertical: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'خصم',
                                style: TextStyle(
                                  color: AppColor.goldLight,
                                  fontSize: w * 0.17,
                                  fontWeight: FontWeight.w800,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.percent.toInt()}',
                                  style: TextStyle(
                                    color: AppColor.mainColor,
                                    fontSize: w * 0.36,
                                    fontWeight: FontWeight.w900,
                                    height: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                      color: AppColor.mainColor,
                                      fontSize: w * 0.17,
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TagPainter extends CustomPainter {
  final double tagH;
  final double stringH;
  final double chamfer;
  final double shine; // 0..1 (خارج المدى = مفيش لمعة)

  _TagPainter({
    required this.tagH,
    required this.stringH,
    required this.chamfer,
    required this.shine,
  });

  Path _tagPath(double w) {
    final c = chamfer;
    final r = w * 0.14;
    final top = stringH;
    final bottom = stringH + tagH;

    return Path()
      ..moveTo(c, top)
      ..lineTo(w - c, top)
      ..lineTo(w, top + c)
      ..lineTo(w, bottom - r)
      ..quadraticBezierTo(w, bottom, w - r, bottom)
      ..lineTo(r, bottom)
      ..quadraticBezierTo(0, bottom, 0, bottom - r)
      ..lineTo(0, top + c)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final path = _tagPath(w);
    final holeCenter = Offset(w / 2, stringH + chamfer * 0.85);

    // الخيط
    final stringPath = Path()
      ..moveTo(w / 2, 0)
      ..quadraticBezierTo(w / 2 + 3, stringH * 0.5, holeCenter.dx, holeCenter.dy);
    canvas.drawPath(
      stringPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.7
        ..strokeCap = StrokeCap.round
        ..color = AppColor.border,
    );

    // المسمار اللي معلّق منه
    canvas.drawCircle(Offset(w / 2, 1.5), 3, Paint()..color = AppColor.goldLight);
    canvas.drawCircle(
      Offset(w / 2, 1.5),
      3,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = AppColor.secondaryColor,
    );

    // الظل
    canvas.drawShadow(path, AppColor.black, 5, true);

    // التعبئة الذهبية
    final rect = Rect.fromLTWH(0, stringH, w, tagH);
    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.goldLight, AppColor.accentColor, AppColor.border],
          stops: [0, 0.55, 1],
        ).createShader(rect),
    );

    // الحد الخارجي
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeJoin = StrokeJoin.round
        ..color = AppColor.secondaryColor,
    );

    // خط داخلي رفيع (إحساس التيكيت المطبوع)
    canvas.save();
    final cx = w / 2;
    final cy = stringH + tagH / 2;
    canvas.translate(cx, cy);
    canvas.scale(0.86, 0.9);
    canvas.translate(-cx, -cy);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9
        ..color = AppColor.mainColor.withOpacity(.35),
    );
    canvas.restore();

    // اللمعة
    if (shine > 0 && shine < 1) {
      final bw = w * 0.34;
      final skew = w * 0.22;
      final x = -bw - skew + (w + bw * 2 + skew * 2) * shine;
      final shinePath = Path()
        ..moveTo(x + skew, stringH)
        ..lineTo(x + skew + bw, stringH)
        ..lineTo(x + bw, stringH + tagH)
        ..lineTo(x, stringH + tagH)
        ..close();

      canvas.save();
      canvas.clipPath(path);
      canvas.drawPath(
        shinePath,
        Paint()
          ..shader = LinearGradient(
            colors: [
              AppColor.white.withOpacity(0),
              AppColor.white.withOpacity(.6),
              AppColor.white.withOpacity(0),
            ],
          ).createShader(Rect.fromLTWH(x, stringH, bw + skew, tagH)),
      );
      canvas.restore();
    }

    // فتحة التعليق
    canvas.drawCircle(holeCenter, w * 0.075, Paint()..color = AppColor.mainColor);
    canvas.drawCircle(
      holeCenter,
      w * 0.075 + 1.6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = AppColor.secondaryColor,
    );
  }

  @override
  bool shouldRepaint(covariant _TagPainter old) =>
      old.shine != shine ||
          old.tagH != tagH ||
          old.stringH != stringH ||
          old.chamfer != chamfer;
}