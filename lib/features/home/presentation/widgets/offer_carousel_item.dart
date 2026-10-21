import 'dart:math' as math;

import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/entities/offer_entity.dart';

String _fmt(num v) => v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(2);
class OfferCarouselItem extends StatelessWidget {
  final OfferEntity offer;

  const OfferCarouselItem({super.key, required this.offer});

  void _open(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteManager.productDetails,
      arguments: offer.productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double radius = 24.r;

    return GestureDetector(
      onTap: () => _open(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.white, AppColor.cardLight],
          ),
          border: Border.all(
            color: AppColor.accentColor.withValues(alpha: .40),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withValues(alpha: .12),
              blurRadius: 20.r,
              offset: Offset(0, 9.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius - 1),
          child: LayoutBuilder(
            builder: (context, c) {
              final double plate = math.min(150.h, c.maxWidth * .42);
              final double textWidth = c.maxWidth - plate - 20.w - 18.w - 10.w;

              return Stack(
                children: [
                  PositionedDirectional(
                    end: -40.w,
                    top: -30.h,
                    child: Container(
                      width: 190.r,
                      height: 190.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.accentColor.withValues(alpha: .10),
                      ),
                    ),
                  ),

                  PositionedDirectional(
                    end: 20.w,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        width: plate,
                        height: plate,
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.goldLight,
                              AppColor.accentColor,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.mainColor.withValues(alpha: .25),
                              blurRadius: 20.r,
                              offset: Offset(0, 10.h),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(3.r),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                          ),
                          child: ClipOval(
                            child: SizedBox.expand(
                              child: CachedNetworkImage(
                                imageUrl: offer.image,
                                fit: BoxFit.cover,
                                placeholder: (_, __) =>
                                const ColoredBox(
                                  color: AppColor.backgroundDark,
                                ),
                                errorWidget: (_, __, ___) =>
                                    Container(
                                      color: AppColor.backgroundDark,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.restaurant_rounded,
                                        color: AppColor.secondaryColor,
                                        size: 38.sp,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  PositionedDirectional(
                    end: 20.w + plate - 52.w,
                    bottom: (180.h - plate) / 2 + 2.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 11.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColor.goldLight,
                            AppColor.accentColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppColor.white.withValues(alpha: 0.9),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.mainColor.withValues(alpha: 0.22),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_offer_rounded,
                            size: 13.sp,
                            color: AppColor.mainColor,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'خصم ${offer.discountPercentage}%',
                            style: StyleManager.font11Weight400.copyWith(
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  PositionedDirectional(
                    start: 20.w,
                    top: 0,
                    bottom: 0,
                    width: textWidth,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: SizedBox(
                        width: textWidth,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // عنوان العرض
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 9.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.accentColor.withValues(
                                    alpha: 0.13),
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              child: Text(
                                'عرض اليوم',
                                style: StyleManager.font12Weight500.copyWith(
                                  color: AppColor.secondaryColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              offer.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font18Weight700.copyWith(
                                color: AppColor.textPrimary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                height: 1.25,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // السعر الأساسي بعد الخصم
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: AlignmentDirectional
                                            .centerStart,
                                        child: Text(
                                          _fmt(offer.priceAfterDiscount),
                                          maxLines: 1,
                                          style: StyleManager.font19Weight700
                                              .copyWith(
                                            color: AppColor.mainColor,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w900,
                                            height: 1,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.h),
                                      child: Text(
                                        'ج.م',
                                        style: StyleManager.font12Weight500
                                            .copyWith(
                                          color: AppColor.secondaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 9.h),

                                // السعر السابق والتوفير
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 9.w,
                                  runSpacing: 5.h,
                                  children: [
                                    Text(
                                      '${_fmt(offer.priceBeforeDiscount)} ج.م',
                                      style: StyleManager.font13Weight400
                                          .copyWith(
                                        color: AppColor.textSecondary
                                            .withValues(alpha: 0.7),
                                        fontSize: 11.sp,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppColor.textSecondary,
                                        decorationThickness: 1.5,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.south_west_rounded,
                                          size: 13.sp,
                                          color: AppColor.mainColor,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          'وفّرت ${_fmt(
                                              offer.priceBeforeDiscount - offer
                                                  .priceAfterDiscount)} ج.م',
                                          style: StyleManager.font12Weight500
                                              .copyWith(
                                            color: AppColor.mainColor,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ), SizedBox(height: 40.h),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
