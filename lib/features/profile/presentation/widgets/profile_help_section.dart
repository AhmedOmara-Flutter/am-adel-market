import 'package:am_adel_market/features/profile/presentation/widgets/profile_option_list.dart';
import '../../../../core/utils/app_imports.dart';

class ProfileHelpSection extends StatelessWidget {
  const ProfileHelpSection({super.key});

  void _go(BuildContext context, String route) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 22.h),

          // عنوان القسم: نص بخط ذهبي قصير تحته
          Padding(
            padding: EdgeInsetsDirectional.only(start: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('المساعدة', style: StyleManager.font16Weight700),
                SizedBox(height: 6.h),
                Container(
                  width: 28.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: AppColor.accentColor,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 14.h),

          // الكارت
          Container(
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColor.divider.withValues(alpha: .5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Column(
                children: [
                  ProfileOptionsList(
                    text: 'من نحن',
                    icon: Icons.info_outline,
                    onTap: () => _go(context, RouteManager.aboutUs),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}