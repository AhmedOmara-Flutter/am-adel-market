import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:am_adel_market/core/entities/bundle_offer_entity.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import '../../../core/helper_function/get_user.dart';
import '../../cart/presentation/view_model/cart_cubit.dart';

/// كارت عرض الكومبو بطابع المطاعم:
/// طبق كبير طالع من فوق الكارت + هالة وحلقة ذهبية + ختم مموّج "سعر خاص"
/// + عنوان بفاصل زخرفي + زرار ذهبي "أضف إلى السلة".
class BundleOfferCard extends StatelessWidget {
  final BundleOfferEntity bundleOffer;

  const BundleOfferCard({super.key, required this.bundleOffer});

  @override
  Widget build(BuildContext context) {
    final double plateSize = 136.r;
    final double plateTop = -24.h;

    // نكتبهم كـ String? عشان يشتغلوا سواء الحقل nullable أو لأ
    final String? description = bundleOffer.description;
    final bool hasDescription =
        description != null && description.trim().isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(top: 35.h, left: 6.w, right: 6.w, bottom: 8.h),
      child: SizedBox(
        width: 220.w,
        height: 245.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // ===== جسم الكارت =====
            Positioned(
              top: 55.h,
              left: 0,
              right: 0,
              height: 190.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.white,
                      AppColor.cardLight,
                      AppColor.background,
                    ],
                  ),
                  border: Border.all(
                    color: AppColor.divider.withValues(alpha: .85),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28.r),
                  child: Stack(
                    children: [
                      // زخرفة خلفية باهتة
                      Positioned(
                        right: -30.r,
                        bottom: -30.r,
                        child: Container(
                          width: 110.r,
                          height: 110.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.accentColor.withValues(alpha: .09),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -26.r,
                        bottom: 40.r,
                        child: Container(
                          width: 70.r,
                          height: 70.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                              AppColor.accentColor.withValues(alpha: .18),
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),

                      // لمعة خفيفة أعلى الكارت
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 60.h,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColor.white.withValues(alpha: .9),
                                AppColor.white.withValues(alpha: 0),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // إطار ذهبي داخلي (شكل المنيو)
                      Positioned.fill(
                        child: Container(
                          margin: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.r),
                            border: Border.all(
                              color:
                              AppColor.accentColor.withValues(alpha: .38),
                              width: 1,
                            ),
                          ),
                        ),
                      ),

                      // المحتوى: العنوان + الفاصل + الزرار
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 68.h, 16.w, 14.h),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      bundleOffer.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                      StyleManager.font14Weight600.copyWith(
                                        color: AppColor.textPrimary,
                                        fontWeight: FontWeight.w800,
                                        height: 1.25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  const _OrnamentDivider(),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            _AddToCartButton(
                              onTap: () {
                                context.read<CartCubit>().addBundleOffer(
                                  bundleOffer,
                                  getUser().uId,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ===== هالة ذهبية خلف الطبق =====
            Positioned(
              top: plateTop - 16.r,
              child: IgnorePointer(
                child: Container(
                  width: plateSize + 32.r,
                  height: plateSize + 32.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColor.goldLight.withValues(alpha: .55),
                        AppColor.goldLight.withValues(alpha: 0),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // ===== حلقة ذهبية رفيعة حوالين الطبق =====
            Positioned(
              top: plateTop - 7.r,
              child: IgnorePointer(
                child: Container(
                  width: plateSize + 14.r,
                  height: plateSize + 14.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.accentColor.withValues(alpha: .4),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            // ===== الطبق (صورة الكومبو) =====
            Positioned(
              top: plateTop,
              child: Container(
                width: plateSize,
                height: plateSize,
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white,
                  border: Border.all(color: AppColor.accentColor, width: 1.6),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.mainColor.withValues(alpha: .25),
                      blurRadius: 18.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: _PlateImage(
                    imageUrl: bundleOffer.image,
                    size: plateSize,
                  ),
                ),
              ),
            ),

            // ===== زرار المعلومات (التولتيب) - بيظهر بس لو في وصف =====
            if (hasDescription)
              Positioned(
                top: 55.h + 12.h,
                right: 12.w,
                child: Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: description,
                  showDuration: const Duration(seconds: 4),
                  preferBelow: false,
                  verticalOffset: 10.h,
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  textStyle: StyleManager.font13Weight400.copyWith(
                    color: AppColor.textOnDark,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.accentColor.withValues(alpha: .35),
                      width: 1.w,
                    ),
                  ),
                  child: Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.white,
                      border: Border.all(
                        color: AppColor.accentColor.withValues(alpha: .6),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.mainColor.withValues(alpha: .12),
                          blurRadius: 8.r,
                          offset: Offset(0, 3.h),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: AppColor.secondaryColor,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),

            // ===== ختم السعر =====
            Positioned(
              top: 2.h,
              left: 0,
              child: Transform.rotate(
                angle: -0.18,
                child: BundleOfferPriceBadge(price: bundleOffer.price),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// صورة الطبق: بتتعامل مع الرابط الفاضي/null من غير ما CachedNetworkImage يرمي error،
/// وبتصغّر الصورة في الميموري على قد حجم العرض.
class _PlateImage extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const _PlateImage({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    final String? url = imageUrl?.trim();
    if (url == null || url.isEmpty) return const _PlateFallback();

    final int cacheSize =
    (size * MediaQuery.devicePixelRatioOf(context)).round();

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      memCacheWidth: cacheSize,
      placeholder: (_, __) => Center(
        child: SizedBox(
          width: 22.r,
          height: 22.r,
          child: const CircularProgressIndicator(
            color: AppColor.accentColor,
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (_, __, ___) => const _PlateFallback(),
    );
  }
}

class _PlateFallback extends StatelessWidget {
  const _PlateFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundDark,
      alignment: Alignment.center,
      child: Icon(
        Icons.fastfood_rounded,
        size: 40.sp,
        color: AppColor.secondaryColor,
      ),
    );
  }
}

/// زرار "أضف إلى السلة" الذهبي
class _AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddToCartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: Material(
        color: AppColor.transparent,
        borderRadius: BorderRadius.circular(22.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(22.r),
          onTap: onTap,
          child: Ink(
            // Directional عشان يتقلب صح مع RTL/LTR
            padding: EdgeInsetsDirectional.only(start: 16.w, end: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.goldLight, AppColor.accentColor],
              ),
              border: Border.all(color: AppColor.white, width: 1.6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'أضف إلى السلة',
                  style: StyleManager.font14Weight600.copyWith(
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  width: 30.r,
                  height: 30.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white.withValues(alpha: .92),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.mainColor.withValues(alpha: .15),
                        blurRadius: 6.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: AppColor.mainColor,
                    size: 17.sp,
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

/// فاصل زخرفي: خط ◆ خط
class _OrnamentDivider extends StatelessWidget {
  const _OrnamentDivider();

  @override
  Widget build(BuildContext context) {
    final Color lineColor = AppColor.accentColor.withValues(alpha: .55);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 34.w, height: 1, color: lineColor),
        SizedBox(width: 6.w),
        Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 6.r,
            height: 6.r,
            color: AppColor.accentColor,
          ),
        ),
        SizedBox(width: 6.w),
        Container(width: 34.w, height: 1, color: lineColor),
      ],
    );
  }
}

/// ختم ذهبي بحافة مموّجة (مرسوم بالكود، من غير أي صورة).
class BundleOfferPriceBadge extends StatelessWidget {
  final double price;

  const BundleOfferPriceBadge({super.key, required this.price});

  /// السعر الصحيح بدل ما نقرّبه: 99.5 يفضل 99.50 مش 100
  String get _priceText =>
      price % 1 == 0 ? price.toStringAsFixed(0) : price.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74.r,
      height: 74.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // RepaintBoundary: الرسم ثابت، فمايتعاد مع كل scroll
          const Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(painter: _ScallopSealPainter()),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'سعر خاص',
                  style: StyleManager.font12Weight500.copyWith(
                    color: AppColor.mainColor,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                SizedBox(height: 2.h),
                // FittedBox عشان الأسعار الكبيرة/العشرية ماتطلعش بره الختم
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _priceText,
                    style: StyleManager.font23Weight700.copyWith(
                      color: AppColor.mainColor,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'ج.م',
                  style: StyleManager.font12Weight500.copyWith(
                    color: AppColor.mainColor,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScallopSealPainter extends CustomPainter {
  const _ScallopSealPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = size.width / 2 - 3;
    const int bumps = 16;

    final Path path = Path();
    // 360 نقطة بس: نقطة 360 هي نفسها نقطة 0، و close() بيقفل الشكل
    for (int i = 0; i < 360; i++) {
      final double theta = i * math.pi / 180;
      final double r = radius * (0.94 + 0.06 * math.cos(bumps * theta));
      final double x = center.dx + r * math.cos(theta);
      final double y = center.dy + r * math.sin(theta);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawShadow(path, AppColor.accentColor, 6, true);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.goldLight, AppColor.accentColor],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..color = AppColor.white,
    );

    canvas.drawCircle(
      center,
      radius * 0.78,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = AppColor.mainColor.withValues(alpha: .28),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}