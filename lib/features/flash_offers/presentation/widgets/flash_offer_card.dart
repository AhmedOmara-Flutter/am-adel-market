import 'package:cached_network_image/cached_network_image.dart';

import 'package:am_adel_market/core/utils/app_imports.dart';

import '../../domain/entities/flash_offer_entity.dart';

class FlashOfferCard extends StatelessWidget {
  final FlashOfferEntity flashOffer;

  const FlashOfferCard({
    super.key,
    required this.flashOffer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(.12),
            blurRadius: 14.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: CachedNetworkImage(
          imageUrl: flashOffer.image ?? '',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          placeholder: (_, __) {
            return Container(
              color: AppColor.backgroundDark,
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: const CircularProgressIndicator(
                    color: AppColor.mainColor,
                    strokeWidth: 2,
                  ),
                ),
              ),
            );
          },
          errorWidget: (_, __, ___) {
            return Container(
              color: AppColor.backgroundDark,
              child: Icon(
                Icons.local_fire_department_rounded,
                color: AppColor.textSecondary,
                size: 42.sp,
              ),
            );
          },
        ),
      ),
    );
  }
}