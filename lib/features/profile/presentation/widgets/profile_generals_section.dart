import 'package:am_adel_market/features/profile/presentation/widgets/profile_option_list.dart';
import '../../../../core/utils/app_imports.dart';

class ProfileGeneralSection extends StatelessWidget {
  const ProfileGeneralSection({super.key});

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
          SizedBox(height: 14.h),

          // عنوان القسم: نص صغير بخط ذهبي قصير تحته
          Padding(
            padding: EdgeInsetsDirectional.only(start: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('عام', style: StyleManager.font16Weight700),
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
                    text: 'الملف الشخصي',
                    icon: Icons.person_2_outlined,
                    onTap: () => _go(context, RouteManager.editProfile),
                  ),
                  const _Divider(),
                  ProfileOptionsList(
                    text: 'طلباتي',
                    icon: Icons.shopping_bag_outlined,
                    onTap: () => _go(context, RouteManager.orders),
                  ),
                  const _Divider(),
                  ProfileOptionsList(
                    text: 'المفضلة',
                    icon: Icons.favorite_border,
                    onTap: () => _go(context, RouteManager.favorite),
                  ),
                  const _Divider(),
                  ProfileOptionsList(
                    text: 'الكوبون',
                    icon: Icons.local_offer_outlined,
                    onTap: () => _go(context, RouteManager.coupon),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// فاصل رفيع بيبدأ من بعد الأيقونة (16 + 40 + 14 = 70)
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 70.w, end: 16.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColor.divider.withValues(alpha: .45),
      ),
    );
  }
}