import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';

/// كارت المنتج غير المتوفر: بيج هادي + صورة رمادية باهتة + شريط "غير متوفر".
/// مفيش ضغط ولا زرار طلب.
class PausedFeaturedItem extends StatelessWidget {
  final ProductEntity productEntity;

  const PausedFeaturedItem({super.key, required this.productEntity});

  static const ColorFilter _grayscale = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    final double plateSize = 82.r;
    final double plateTop = 6.h;

    return SizedBox(
      width: 112.w,
      height: 158.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // ===== الكارت =====
          Positioned(
            top: 48.h,
            child: Container(
              width: 110.w,
              height: 102.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.r),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.backgroundDark, AppColor.background],
                ),
                border: Border.all(
                  color: AppColor.red.withOpacity(.11),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mainColor.withOpacity(.06),
                    blurRadius: 18.r,
                    offset: Offset(0, 9.h),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26.r),
                child: Stack(
                  children: [
                    Positioned(
                      right: -22.r,
                      bottom: -22.r,
                      child: Container(
                        width: 70.r,
                        height: 70.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.accentColor.withOpacity(.04),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -14.r,
                      top: 30.r,
                      child: Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.accentColor.withOpacity(.08),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),

                    // اسم المنتج
                    Padding(
                      padding: EdgeInsets.only(
                        top: 46.h,
                        left: 8.w,
                        right: 8.w,
                        bottom: 20.h,
                      ),
                      child: Center(
                        child: Text(
                          productEntity.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font14Weight600.copyWith(
                            color: AppColor.textSecondary.withOpacity(.7),
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ===== الطبق (الصورة رمادية باهتة) =====
          Positioned(
            top: plateTop,
            child: Container(
              width: plateSize,
              height: plateSize,
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white,
                border: Border.all(color: AppColor.divider, width: 1.4),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mainColor.withOpacity(.12),
                    blurRadius: 14.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: ClipOval(
                child: Opacity(
                  opacity: .55,
                  child: ColorFiltered(
                    colorFilter: _grayscale,
                    child: CachedNetworkImage(
                      imageUrl: productEntity.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Center(
                        child: SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: const CircularProgressIndicator(
                            color: AppColor.border,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColor.backgroundDark,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.fastfood_rounded,
                          size: 32.sp,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ===== شريط "غير متوفر" =====
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColor.red,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColor.white, width: 1.8),
              ),
              child: Text(
                'غير متوفر حاليًا',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: StyleManager.font11Weight400.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}