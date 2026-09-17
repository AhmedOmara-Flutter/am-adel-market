import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_imports.dart';

class CartItemImage extends StatelessWidget {
  final String image;

  const CartItemImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      height: 95.w,
      padding: EdgeInsets.all(7.w),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.06),
            blurRadius: 12.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.r),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          fadeInDuration: const Duration(milliseconds: 250),
          placeholder: (_, __) => Center(
            child: SizedBox(
              width: 22.w,
              height: 22.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColor.accentColor,
              ),
            ),
          ),
          errorWidget: (_, __, ___) => Icon(
            Icons.fastfood_rounded,
            color: AppColor.mainColor,
            size: 28.sp,
          ),
        ),
      ),
    );
  }
}