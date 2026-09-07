import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

class BestSellingSection extends StatelessWidget {
  const BestSellingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w,right: 20.w, top: 18.h,bottom: 28.h),
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
            '⭐ الأكثر طلبًا',
            style: StyleManager.font16Weight700.copyWith(
              color: AppColor.textPrimary,
            ),
          ),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColor.mainColor,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.bestSellingMore);
            },
            child: Text(
              'المزيد',
              style: StyleManager.font14Weight600.copyWith(
                color: AppColor.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
