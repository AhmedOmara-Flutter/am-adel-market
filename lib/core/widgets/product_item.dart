import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import '../../features/cart/presentation/view_model/cart_cubit.dart';
import '../../features/favorite/presentation/view_model/favorite_cubit.dart';
import '../../features/offers/presentation/view_model/offer_cubit.dart';
import '../cubit/product_cubit/product_cubit.dart';
import '../entities/product_entity.dart';
import '../helper_function/get_user.dart';
import '../utils/app_imports.dart';

/// السعر من غير تقريب: 99 تفضل 99، و 99.5 تبقى 99.50
String _fmt(num v) => v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(2);

class ProductItem extends StatelessWidget {
  final ProductEntity product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.isPaused) {
      return PausedProductItem(product: product);
    }
    return ActiveProductItem(product: product);
  }
}

// ============================================================
//  المنتج المتاح
// ============================================================
class ActiveProductItem extends StatelessWidget {
  final ProductEntity product;

  const ActiveProductItem({super.key, required this.product});

  Future<void> _onTap(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await AppSounds.playClickSound('click_song.wav');

    if (!context.mounted) return;

    Navigator.pushNamed(
      context,
      RouteManager.productDetails,
      arguments: product.id,
    );
    context.read<ProductCubit>().increaseSellingCount(product.id);
  }

  @override
  Widget build(BuildContext context) {
    final offer = context.watch<OfferCubit>().offersMap[product.id];
    final bool hasOffer = offer != null && offer.isActive;

    final Widget price = hasOffer
        ? Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '${_fmt(offer.priceAfterDiscount)} ج.م',
          style: StyleManager.font14Weight600.copyWith(
            color: AppColor.mainColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          '${_fmt(offer.priceBeforeDiscount)} ج.م',
          style: StyleManager.font12Weight500.copyWith(
            color: AppColor.textSecondary,
            fontSize: 11.sp,
            decoration: TextDecoration.lineThrough,
            decorationColor: AppColor.textPrimary,
          ),
        ),
      ],
    )
        : Text(
      '${_fmt(product.price)} ج.م',
      style: StyleManager.font14Weight600.copyWith(
        color: AppColor.mainColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
    );

    return _PressScale(
      onTap: () => _onTap(context),
      child: _ProductCardShell(
        imageUrl: product.image,
        muted: false,
        middle: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font14Weight600.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
            SizedBox(height: 4.h),
            const _OrnamentDivider(),
            SizedBox(height: 4.h),
            price,
          ],
        ),
        footer: _GoldAddButton(
          onTap: () {
            context.read<CartCubit>().addProduct(
              product,
              offer,
              getUser().uId,
            );
          },
        ),
        overlays: [
          // المفضلة (يمين)
          Positioned(
            top: 4.h,
            right: 4.w,
            child: _FavoriteButton(product: product),
          ),
          // ختم الخصم (يسار)
          if (hasOffer)
            Positioned(
              top: 0,
              left: 2.w,
              child: Transform.rotate(
                angle: -0.18,
                child: _DiscountSeal(percent: offer.discountPercentage.toInt()),
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================
//  المنتج المتوقف
// ============================================================
class PausedProductItem extends StatelessWidget {
  final ProductEntity product;

  const PausedProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return _ProductCardShell(
      imageUrl: product.image,
      muted: true,
      middle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            product.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.font14Weight600.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '${_fmt(product.price)} ج.م',
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.textSecondary,
              fontSize: 13.sp,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
      footer: Container(
        height: 34.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColor.red.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.red.withValues(alpha: .25)),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'غير متوفر حاليًا',
            style: StyleManager.font11Weight400.copyWith(
              color: AppColor.red,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
//  هيكل الكارت المشترك (طبق طالع من فوق + جسم الكارت)
//  بيتحجّم حسب مساحة الخلية في الـ Grid، والطبق جوه حدودها.
// ============================================================
class _ProductCardShell extends StatelessWidget {
  final String? imageUrl;
  final bool muted;
  final Widget middle;
  final Widget footer;
  final List<Widget> overlays;

  const _ProductCardShell({
    required this.imageUrl,
    required this.muted,
    required this.middle,
    required this.footer,
    this.overlays = const [],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final double w = c.maxWidth.isFinite ? c.maxWidth : 170.w;
        final double h = c.maxHeight.isFinite ? c.maxHeight : 230.h;

        final double plate = math.min(w * 0.56, h * 0.42);
        final double bodyTop = plate * 0.5;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // ===== جسم الكارت =====
            Positioned(
              top: bodyTop,
              left: 0,
              right: 0,
              bottom: 4.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.r),
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
                    color: AppColor.divider.withValues(alpha: muted ? .5 : .25),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.mainColor
                          .withValues(alpha: muted ? .05 : .12),
                      blurRadius: 16.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26.r),
                  child: Stack(
                    children: [
                      if (!muted) ...[
                        // زخرفة باهتة في الركن
                        Positioned(
                          right: -22.r,
                          bottom: -22.r,
                          child: Container(
                            width: 70.r,
                            height: 70.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                              AppColor.accentColor.withValues(alpha: .09),
                            ),
                          ),
                        ),
                        // إطار ذهبي داخلي (شكل المنيو)
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              border: Border.all(
                                color:
                                AppColor.accentColor.withValues(alpha: .30),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ],

                      // المحتوى
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          10.w,
                          bodyTop + 6.h,
                          10.w,
                          10.h,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, box) => Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: SizedBox(
                                      width: box.maxWidth,
                                      child: middle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            footer,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ===== الطبق =====
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: _Plate(size: plate, imageUrl: imageUrl, muted: muted),
              ),
            ),

            ...overlays,
          ],
        );
      },
    );
  }
}

/// الطبق: هالة ذهبية + حلقة رفيعة + صورة دايرية
class _Plate extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final bool muted;

  const _Plate({
    required this.size,
    required this.imageUrl,
    required this.muted,
  });

  static const ColorFilter _grey = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    Widget image = ClipOval(
      child: _PlateImage(imageUrl: imageUrl, size: size),
    );
    if (muted) {
      image = Opacity(
        opacity: .55,
        child: ColorFiltered(colorFilter: _grey, child: image),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!muted) ...[
            // هالة ذهبية
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColor.goldLight.withValues(alpha: .5),
                        AppColor.goldLight.withValues(alpha: 0),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            // حلقة رفيعة
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(3.r),
                child: DecoratedBox(
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
          ],

          // الطبق نفسه
          Padding(
            padding: EdgeInsets.all(7.r),
            child: Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white,
                border: Border.all(
                  color: muted ? AppColor.divider : AppColor.accentColor,
                  width: 1.4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mainColor
                        .withValues(alpha: muted ? .08 : .20),
                    blurRadius: 14.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: SizedBox.expand(child: image),
            ),
          ),
        ],
      ),
    );
  }
}

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
          width: 20.r,
          height: 20.r,
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
        size: 32.sp,
        color: AppColor.secondaryColor,
      ),
    );
  }
}

// ============================================================
//  عناصر صغيرة
// ============================================================

/// ضغطة بتصغّر الكارت شوية (زي كارت المميزات)
class _PressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _PressScale({required this.child, required this.onTap});

  @override
  State<_PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<_PressScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
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
        scale: _pressed ? .96 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// زرار المفضلة الدايري
class _FavoriteButton extends StatelessWidget {
  final ProductEntity product;

  const _FavoriteButton({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final bool isFavorite =
            context.read<FavoriteCubit>().favorites[product.id] ?? false;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.read<FavoriteCubit>().toggleFavorite(product),
          child: Container(
            width: 32.r,
            height: 32.r,
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
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 18.sp,
              color: isFavorite
                  ? const Color(0xffEB5757)
                  : AppColor.textSecondary,
            ),
          ),
        );
      },
    );
  }
}

/// زرار "أضف للسلة" الذهبي
class _GoldAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _GoldAddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 34.h,
      child: Material(
        color: AppColor.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: onTap,
          child: Ink(
            padding: EdgeInsetsDirectional.only(start: 10.w, end: 3.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.goldLight, AppColor.accentColor],
              ),
              border: Border.all(color: AppColor.white, width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'أضف إلى السلة',
                      style: StyleManager.font12Weight500.copyWith(
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  width: 26.r,
                  height: 26.r,
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
                    size: 15.sp,
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
        Container(width: 24.w, height: 1, color: lineColor),
        SizedBox(width: 5.w),
        Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 5.r,
            height: 5.r,
            color: AppColor.accentColor,
          ),
        ),
        SizedBox(width: 5.w),
        Container(width: 24.w, height: 1, color: lineColor),
      ],
    );
  }
}

/// ختم ذهبي مموّج لنسبة الخصم
class _DiscountSeal extends StatelessWidget {
  final int percent;

  const _DiscountSeal({required this.percent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.r,
      height: 48.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(painter: _ScallopSealPainter()),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '%$percent',
                    style: StyleManager.font14Weight600.copyWith(
                      color: AppColor.mainColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'خصم',
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.mainColor,
                    fontSize: 8.sp,
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
    final double radius = size.width / 2 - 2;
    const int bumps = 14;

    final Path path = Path();
    for (int i = 0; i < 360; i++) {
      final double theta = i * math.pi / 180;
      final double r = radius * (0.93 + 0.07 * math.cos(bumps * theta));
      final double x = center.dx + r * math.cos(theta);
      final double y = center.dy + r * math.sin(theta);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawShadow(path, AppColor.accentColor, 4, true);

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
        ..strokeWidth = 1.8
        ..color = AppColor.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}