import 'package:am_adel_market/features/profile/presentation/widgets/profile_option_list.dart';
import '../../../../core/utils/app_imports.dart';

class ProfileGeneralSection extends StatelessWidget {
  const ProfileGeneralSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          Text(
            'عام',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColor.textSecondary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 14.h),

          ProfileOptionsList(
            text: 'الملف الشخصي',
            icon: Icons.person_2_outlined,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.editProfile);
            },
          ),

          ProfileOptionsList(
            text: 'طلباتي',
            icon: Icons.shopping_bag_outlined,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.orders);
            },
          ),

          ProfileOptionsList(
            text: 'المفضلة',
            icon: Icons.favorite_border,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.favorite);
            },
          ),
          ProfileOptionsList(
            text: 'الكوبون',
            icon: Icons.local_offer_outlined,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.coupon);
            },
          ),

        ],
      ),
    );
  }
}