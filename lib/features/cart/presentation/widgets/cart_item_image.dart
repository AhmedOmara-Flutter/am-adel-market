import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/utils/app_imports.dart';

/// صورة عنصر السلة على شكل طبق دايري:
/// هالة ذهبية + حلقة رفيعة + طبق أبيض بإطار ذهبي.
class CartItemImage extends StatelessWidget {
  final String? image;
  final double? size;

  const CartItemImage({
    super.key,
    required this.image,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final double s = size ?? 88.r;

    return SizedBox(
      width: s,
      height: s,
      child: Stack(
        alignment: Alignment.center,
        children: [
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
              padding: EdgeInsets.all(2.r),
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

          // الطبق نفسه
          Padding(
            padding: EdgeInsets.all(6.r),
            child: Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white,
                border: Border.all(color: AppColor.accentColor, width: 1.4),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mainColor.withValues(alpha: .18),
                    blurRadius: 12.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
              ),
              child: ClipOval(
                child: SizedBox.expand(
                  child: _PlateImage(imageUrl: image, size: s),
                ),
              ),
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
      fadeInDuration: const Duration(milliseconds: 250),
      placeholder: (_, __) => Center(
        child: SizedBox(
          width: 20.r,
          height: 20.r,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColor.accentColor,
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
        size: 28.sp,
        color: AppColor.secondaryColor,
      ),
    );
  }
}