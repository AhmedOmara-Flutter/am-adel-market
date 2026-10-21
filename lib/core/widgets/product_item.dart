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

const LinearGradient _gold = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColor.goldLight, AppColor.accentColor],
);

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
//  الطبق المتاح
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

    return _PressScale(
      onTap: () => _onTap(context),
      child: _PlateCard(
        imageUrl: product.image,
        muted: false,
        name: product.name,
        price: hasOffer ? offer.priceAfterDiscount : product.price,
        oldPrice: hasOffer ? offer.priceBeforeDiscount : null,
        discountPercent: hasOffer ? offer.discountPercentage.toInt() : null,
        favorite: _FavoriteButton(product: product),
        onAdd: () {
          context.read<CartCubit>().addProduct(
            product,
            offer,
            getUser().uId,
          );
        },
      ),
    );
  }
}

// ============================================================
//  الطبق المتوقف
// ============================================================
class PausedProductItem extends StatelessWidget {
  final ProductEntity product;

  const PausedProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return _PlateCard(
      imageUrl: product.image,
      muted: true,
      name: product.name,
      price: product.price,
      oldPrice: null,
      discountPercent: null,
      favorite: null,
      onAdd: null,
    );
  }
}

// ============================================================
//  الكارت: طبق دايري كبير طالع من فوق كارت كريمي،
//  والسعر تحت، وزرار الإضافة تبويبة ذهبية في ركن الكارت.
// ============================================================
class _PlateCard extends StatelessWidget {
  final String? imageUrl;
  final bool muted;
  final String name;
  final num price;
  final num? oldPrice;
  final int? discountPercent;
  final Widget? favorite;
  final VoidCallback? onAdd;

  const _PlateCard({
    required this.imageUrl,
    required this.muted,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discountPercent,
    required this.favorite,
    required this.onAdd,
  });

  static const ColorFilter _grey = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    final double radius = 26.r;

    return LayoutBuilder(
      builder: (context, c) {
        final double w = c.maxWidth.isFinite ? c.maxWidth : 170.w;
        final double h = c.maxHeight.isFinite ? c.maxHeight : w * 1.25;

        final double plate = math.min(w * .68, h * .52);
        final double bodyTop = plate * .45;

        Widget image = _DishImage(url: imageUrl, width: plate);
        if (muted) {
          image = Opacity(
            opacity: .55,
            child: ColorFiltered(colorFilter: _grey, child: image),
          );
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // ===== جسم الكارت =====
            Positioned(
              top: bodyTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColor.white, AppColor.cardLight],
                  ),
                  border: Border.all(
                    color: muted
                        ? AppColor.divider.withValues(alpha: .6)
                        : AppColor.accentColor.withValues(alpha: .40),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.mainColor.withValues(
                        alpha: muted ? .05 : .13,
                      ),
                      blurRadius: 18.r,
                      offset: Offset(0, 9.h),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius - 1),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // زخرفة دايرة باهتة في الركن
                      PositionedDirectional(
                        start: -26.r,
                        bottom: -26.r,
                        child: Container(
                          width: 90.r,
                          height: 90.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.accentColor.withValues(
                              alpha: muted ? .04 : .09,
                            ),
                          ),
                        ),
                      ),

                      // المحتوى
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          12.w,
                          plate - bodyTop + 6.h,
                          12.w,
                          10.h,
                        ),
                        child: LayoutBuilder(
                          builder: (context, box) => FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: box.maxWidth,
                              child: _Content(
                                muted: muted,
                                name: name,
                                price: price,
                                oldPrice: oldPrice,
                                reserveForTab: onAdd != null,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // تبويبة الإضافة في ركن الكارت
                      if (onAdd != null)
                        PositionedDirectional(
                          bottom: 0,
                          end: 0,
                          child: _AddTab(onTap: onAdd!, radius: radius),
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
                child: SizedBox(
                  width: plate,
                  height: plate,
                  child: _Plate(
                    muted: muted,
                    child: image,
                  ),
                ),
              ),
            ),

            // شارة "نفد"
            if (muted)
              Positioned(
                top: plate * .5 - 13.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .62),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColor.white.withValues(alpha: .25),
                      ),
                    ),
                    child: Text(
                      'نفد من القائمة اليوم',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

            // ختم الخصم
            if (discountPercent != null)
              PositionedDirectional(
                top: 2.h,
                start: 4.w,
                child: _DiscountSeal(percent: discountPercent!),
              ),

            // المفضلة
            if (favorite != null)
              PositionedDirectional(
                top: 2.h,
                end: 4.w,
                child: favorite!,
              ),
          ],
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  final bool muted;
  final String name;
  final num price;
  final num? oldPrice;
  final bool reserveForTab;

  const _Content({
    required this.muted,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.reserveForTab,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font14Weight600.copyWith(
            color: muted ? AppColor.textSecondary : AppColor.textPrimary,
            fontWeight: FontWeight.w800,
            height: 1.25,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (muted)
                    Text(
                      '${_fmt(price)} ج.م',
                      style: StyleManager.font12Weight500.copyWith(
                        color: AppColor.textSecondary,
                        fontSize: 13.sp,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  else
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: _fmt(price),
                            style: StyleManager.font14Weight600.copyWith(
                              color: AppColor.mainColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                            ),
                          ),
                          TextSpan(
                            text: ' ج.م',
                            style: StyleManager.font12Weight500.copyWith(
                              color: AppColor.secondaryColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (oldPrice != null)
                    Text(
                      '${_fmt(oldPrice!)} ج.م',
                      style: StyleManager.font12Weight500.copyWith(
                        color: AppColor.textSecondary,
                        fontSize: 11.sp,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColor.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (reserveForTab) SizedBox(width: 40.r),
          ],
        ),
      ],
    );
  }
}

// ============================================================
//  عناصر صغيرة
// ============================================================

/// الطبق: حلقة ذهبية + حلقة بيضا + ظل ناعم تحته
class _Plate extends StatelessWidget {
  final Widget child;
  final bool muted;

  const _Plate({required this.child, required this.muted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: muted ? null : _gold,
        color: muted ? AppColor.divider : null,
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: muted ? .08 : .28),
            blurRadius: 20.r,
            offset: Offset(0, 11.h),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(3.r),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.white,
        ),
        child: ClipOval(child: SizedBox.expand(child: child)),
      ),
    );
  }
}

/// تبويبة الإضافة: ركن ذهبي بيكمّل انحناء الكارت
class _AddTab extends StatelessWidget {
  final VoidCallback onTap;
  final double radius;

  const _AddTab({required this.onTap, required this.radius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 50.r,
        height: 46.r,
        decoration: BoxDecoration(
          gradient: _gold,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(22.r),
            bottomEnd: Radius.circular(radius),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.accentColor.withValues(alpha: .45),
              blurRadius: 10.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Icon(
          Icons.add_shopping_cart_rounded,
          color: AppColor.mainColor,
          size: 22.sp,
        ),
      ),
    );
  }
}

/// ختم الخصم: دايرة ذهبية فيها النسبة
class _DiscountSeal extends StatelessWidget {
  final int percent;

  const _DiscountSeal({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _gold,
        border: Border.all(color: AppColor.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentColor.withValues(alpha: .55),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '%$percent',
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.mainColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          Text(
            'خصم',
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.mainColor,
              fontSize: 8.sp,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

/// زرار المفضلة: دايرة بيضا بظل ناعم
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
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
              border: Border.all(
                color: AppColor.accentColor.withValues(alpha: .35),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.mainColor.withValues(alpha: .15),
                  blurRadius: 8.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 19.sp,
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

class _DishImage extends StatelessWidget {
  final String? url;
  final double width;

  const _DishImage({required this.url, required this.width});

  @override
  Widget build(BuildContext context) {
    final String? u = url?.trim();
    if (u == null || u.isEmpty) return const _ImageFallback();

    final int cacheWidth =
    (width * MediaQuery.devicePixelRatioOf(context)).round();

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
      errorWidget: (_, __, ___) => const _ImageFallback(),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundDark,
      alignment: Alignment.center,
      child: Icon(
        Icons.restaurant_rounded,
        size: 40.sp,
        color: AppColor.secondaryColor,
      ),
    );
  }
}

/// ضغطة بتصغّر الكارت شوية
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
        scale: _pressed ? .97 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}