import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_imports.dart';

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      child: Row(
        children: [
          Container(
            width: 5.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            "👨‍🍳 مختارات الشيف",
            style: StyleManager.font16Weight700.copyWith(
              color: AppColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}