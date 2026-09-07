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
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.7),
          width: 1.2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
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
              color: AppColor.mainColor,
            ),
          ),
        ),
        errorWidget: (_, __, ___) => Icon(
          Icons.fastfood_rounded,
          color: AppColor.mainColor,
          size: 28.sp,
        ),
      ),
    );
  }
}