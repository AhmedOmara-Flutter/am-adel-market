import 'package:cached_network_image/cached_network_image.dart';
import 'package:am_adel_market/core/entities/bundle_offer_entity.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import '../../../core/helper_function/get_user.dart';
import '../../cart/presentation/view_model/cart_cubit.dart';

/// كارت كومبو بطابع "واجهة عرض" فاخرة:
/// صورة بشكل قوس بإطار ذهبي مزدوج طالعة من فوق الكارت
/// + سعر خاص على حرف الصورة + الاسم والوصف جوا الكارت + زرار بني بحدود ذهبية.

class BundleOfferCard extends StatelessWidget {
  final BundleOfferEntity bundleOffer;

  const BundleOfferCard({
    super.key,
    required this.bundleOffer,
  });

  @override
  Widget build(BuildContext context) {
    final String? description = bundleOffer.description;
    final bool hasDescription =
        description != null && description.trim().isNotEmpty;

    return Container(
      width: 310.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColor.divider.withOpacity(.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: 0.10),
            blurRadius: 14.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة العرض
              Container(
                width: 112.w,
                height: 122.h,
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColor.goldLight,
                      AppColor.accentColor,
                      AppColor.border,
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: _ArchImage(
                    imageUrl: bundleOffer.image,
                    width: 112.w,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // تفاصيل العرض
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.accentColor.withValues(
                          alpha: 0.16,
                        ),
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      child: Text(
                        'عرض كومبو',
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.secondaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      bundleOffer.title,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font14Weight600.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                      ),
                    ),

                    if (hasDescription) ...[
                      SizedBox(height: 6.h),
                      Text(
                        description.trim(),
                        textAlign: TextAlign.start,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 11.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // فاصل ذهبي
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColor.divider.withValues(alpha: 0.7),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 15.sp,
                  color: AppColor.accentColor,
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColor.divider.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // السعر والزرار
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'سعر العرض',
                      style: StyleManager.font12Weight500.copyWith(
                        color: AppColor.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              bundleOffer.price % 1 == 0
                                  ? bundleOffer.price.toStringAsFixed(0)
                                  : bundleOffer.price.toStringAsFixed(2),
                              style: StyleManager.font23Weight700.copyWith(
                                color: AppColor.mainColor,
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'ج.م',
                          style: StyleManager.font12Weight500.copyWith(
                            color: AppColor.secondaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                flex: 2,
                child: _AddToCartButton(
                  onTap: () {
                    context.read<CartCubit>().addBundleOffer(
                      bundleOffer,
                      getUser().uId,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// صورة القوس: بتتعامل مع الرابط الفاضي/null، وبتصغّر الصورة في الميموري.
class _ArchImage extends StatelessWidget {
  final String? imageUrl;
  final double width;

  const _ArchImage({required this.imageUrl, required this.width});

  @override
  Widget build(BuildContext context) {
    final String? url = imageUrl?.trim();
    if (url == null || url.isEmpty) return const _ArchFallback();

    final int cacheWidth =
    (width * MediaQuery.devicePixelRatioOf(context)).round();

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      memCacheWidth: cacheWidth,
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
      errorWidget: (_, __, ___) => const _ArchFallback(),
    );
  }
}

class _ArchFallback extends StatelessWidget {
  const _ArchFallback();

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


class _AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddToCartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: Material(
        color: AppColor.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Ink(
            padding: EdgeInsetsDirectional.only(
              start: 14.w,
              end: 6.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
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
                  color: AppColor.accentColor.withValues(alpha: 0.22),
                  blurRadius: 8.r,
                  offset: Offset(0, 3.h),
                ),
              ],
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
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.mainColor.withValues(alpha: 0.10),
                        blurRadius: 5.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: AppColor.mainColor,
                    size: 18.sp,
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

/// سعر خاص: كبسولة ذهبية بتقعد على حرف الصورة.
class BundleOfferPriceBadge extends StatelessWidget {
  final double price;

  const BundleOfferPriceBadge({super.key, required this.price});

  /// السعر الصحيح بدل ما نقرّبه: 99.5 يفضل 99.50 مش 100
  String get _priceText =>
      price % 1 == 0 ? price.toStringAsFixed(0) : price.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.goldLight, AppColor.accentColor],
        ),
        border: Border.all(color: AppColor.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColor.accentColor.withValues(alpha: .55),
            blurRadius: 12.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            'سعر خاص',
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.mainColor,
              fontSize: 9.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            _priceText,
            style: StyleManager.font23Weight700.copyWith(
              color: AppColor.mainColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          SizedBox(width: 3.w),
          Text(
            'ج.م',
            style: StyleManager.font12Weight500.copyWith(
              color: AppColor.mainColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}