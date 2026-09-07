import '../../../core/utils/app_imports.dart';

class BundleOfferSection extends StatelessWidget {
  const BundleOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20.w, right: 20.w, bottom: 20.h, top: 10.h),
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
            "🎁 لقمتك على مزاجك",
            style: StyleManager.font16Weight700.copyWith(
              color: AppColor.textPrimary,
            ),
          )
        ],
      ),
    );
  }
}