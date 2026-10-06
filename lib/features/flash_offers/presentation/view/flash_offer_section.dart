
import '../../../../core/utils/app_imports.dart';

class FlashOfferSection extends StatelessWidget {
  const FlashOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 10.h,
      ),
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
            "⚡ لقطة اليوم",
            style: StyleManager.font16Weight700.copyWith(
              color: AppColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}