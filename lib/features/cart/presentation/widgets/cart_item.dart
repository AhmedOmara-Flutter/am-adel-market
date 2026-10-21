import 'dart:math' as math;
import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/cart/domain/entities/cart_item_entity.dart';
import 'package:am_adel_market/features/cart/presentation/widgets/cart_item_image.dart';
import 'package:am_adel_market/features/cart/presentation/widgets/quality_control.dart';
import '../../domain/entities/bundle_offer_cart_item_entity.dart';
import '../view_model/cart_cubit.dart';

String _fmt(num v) => v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(2);

class CartItem extends StatelessWidget {
  final CartItemEntity cartItemEntity;

  const CartItem({
    super.key,
    required this.cartItemEntity,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBundle = cartItemEntity is BundleOfferCartItemEntity;
    final String? image = cartItemEntity.product.image;

    Widget plate = CartItemImage(image: image, size: 96.r);
    if (!isBundle) {
      plate = GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteManager.productDetails,
            arguments: cartItemEntity.product.id,
          );
        },
        child: plate,
      );
    }

    return Container(
      margin: EdgeInsets.only(left:Constants.screenHorizontal,right: Constants.screenHorizontal, bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: .10),
            blurRadius: 22.r,
            offset: Offset(0, 10.h),
          ),
          BoxShadow(
            color: AppColor.accentColor.withValues(alpha: .10),
            blurRadius: 14.r,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.r),
        child: DecoratedBox(
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
              color: AppColor.accentColor.withValues(alpha: .40),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              // زخرفة باهتة في الركن
              Positioned(
                right: -34.r,
                bottom: -34.r,
                child: IgnorePointer(
                  child: Container(
                    width: 120.r,
                    height: 120.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.accentColor.withValues(alpha: .08),
                    ),
                  ),
                ),
              ),

              // لمعة من فوق
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 56.h,
                child: IgnorePointer(
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
              ),

              // المحتوى
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ===== الجزء العلوي: الطبق + التفاصيل =====
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // الطبق + ختم الكمية
                        SizedBox(
                          width: 96.r,
                          height: 96.r,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned.fill(child: plate),
                              PositionedDirectional(
                                bottom: 0,
                                end: -2.w,
                                child: IgnorePointer(
                                  child: _QuantitySeal(
                                    quantity: cartItemEntity.quantity,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // الاسم + الحذف
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Text(
                                        cartItemEntity.product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                        StyleManager.font15Weight700.copyWith(
                                          color: AppColor.textPrimary,
                                          fontWeight: FontWeight.w800,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  _DeleteButton(
                                    onTap: () {
                                      context.read<CartCubit>().deleteCartItem(
                                        cartItemEntity,
                                        getUser().uId,
                                      );
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // فاصل صغير + وسم الكومبو
                              Row(
                                children: [
                                  const _MiniOrnament(),
                                  if (isBundle) ...[
                                    SizedBox(width: 8.w),
                                    const _BundleTag(),
                                  ],
                                ],
                              ),

                              SizedBox(height: 8.h),

                              // سعر الوحدة
                              Text(
                                'سعر الوحدة  ${_fmt(cartItemEntity.unitPrice)} ج.م',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: StyleManager.font13Weight600.copyWith(
                                  color: AppColor.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // ===== فاصل مخرّم ذهبي (زي التذكرة) =====
                    SizedBox(
                      height: 10.h,
                      width: double.infinity,
                      child: const CustomPaint(painter: _TicketDividerPainter()),
                    ),

                    SizedBox(height: 12.h),

                    // ===== الجزء السفلي: الكمية + الإجمالي =====
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        QualityControl(cartItemEntity: cartItemEntity),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _TotalPill(
                            total:
                            cartItemEntity.unitPrice * cartItemEntity.quantity,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ختم ذهبي صغير بالكمية على حرف الطبق
class _QuantitySeal extends StatelessWidget {
  final int quantity;

  const _QuantitySeal({required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 28.r),
      height: 28.r,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.goldLight, AppColor.accentColor],
        ),
        border: Border.all(color: AppColor.white, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentColor.withValues(alpha: .5),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Text(
        '×$quantity',
        style: StyleManager.font12Weight500.copyWith(
          color: AppColor.mainColor,
          fontWeight: FontWeight.w900,
          height: 1,
        ),
      ),
    );
  }
}

/// وسم "كومبو" للعروض المجمّعة
class _BundleTag extends StatelessWidget {
  const _BundleTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.accentColor.withValues(alpha: .14),
        border: Border.all(
          color: AppColor.accentColor.withValues(alpha: .5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.card_giftcard_rounded,
            size: 11.sp,
            color: AppColor.mainColor,
          ),
          SizedBox(width: 3.w),
          Text(
            'كومبو',
            style: StyleManager.font11Weight400.copyWith(
              color: AppColor.mainColor,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// زرار الحذف
class _DeleteButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DeleteButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        splashColor: AppColor.red.withValues(alpha: .12),
        highlightColor: AppColor.red.withValues(alpha: .06),
        child: Ink(
          width: 34.w,
          height: 34.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.red.withValues(alpha: .07),
            border: Border.all(
              color: AppColor.red.withValues(alpha: .20),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.delete_outline_rounded,
            color: AppColor.red,
            size: 18.sp,
          ),
        ),
      ),
    );
  }
}

/// فاصل زخرفي صغير: ◆ وخط ذهبي بيتلاشى
class _MiniOrnament extends StatelessWidget {
  const _MiniOrnament();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 5.r,
            height: 5.r,
            color: AppColor.accentColor,
          ),
        ),
        SizedBox(width: 5.w),
        Container(
          width: 30.w,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.accentColor.withValues(alpha: .6),
                AppColor.accentColor.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// كبسولة الإجمالي: خلفية داكنة + حد ذهبي + سعر ذهبي
class _TotalPill extends StatelessWidget {
  final num total;

  const _TotalPill({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColor.goldLight.withValues(alpha: 0.8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: 0.05),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(7.r),
            decoration: BoxDecoration(
              color: AppColor.goldLight.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              color: AppColor.mainColor,
              size: 17.sp,
            ),
          ),
          SizedBox(width: 9.w),
          Text(
            'الإجمالي',
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                '${_fmt(total)} ج.م',
                style: StyleManager.font15Weight700.copyWith(
                  color: AppColor.mainColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/// فاصل مخرّم ذهبي زي تذكرة: شرطات صغيرة + ◆ في النص
class _TicketDividerPainter extends CustomPainter {
  const _TicketDividerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height / 2;
    final double cx = size.width / 2;
    const double gap = 8; // مسافة حوالين الـ ◆

    final Paint dash = Paint()
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..color = AppColor.accentColor.withValues(alpha: .55);

    const double dashLen = 5;
    const double dashGap = 4;

    void drawDashes(double from, double to) {
      double x = from;
      while (x < to) {
        canvas.drawLine(
          Offset(x, cy),
          Offset(math.min(x + dashLen, to), cy),
          dash,
        );
        x += dashLen + dashGap;
      }
    }

    drawDashes(0, cx - gap - 4);
    drawDashes(cx + gap + 4, size.width);

    // ◆ في النص
    final Path diamond = Path()
      ..moveTo(cx, cy - 4)
      ..lineTo(cx + 4, cy)
      ..lineTo(cx, cy + 4)
      ..lineTo(cx - 4, cy)
      ..close();

    canvas.drawPath(
      diamond,
      Paint()
        ..shader = const LinearGradient(
          colors: [AppColor.goldLight, AppColor.accentColor],
        ).createShader(Rect.fromCenter(center: Offset(cx, cy), width: 8, height: 8)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}