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
            image: Assets.assets.images.user.path,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.editProfile);
            },
          ),

          ProfileOptionsList(
            text: 'طلباتي',
            image: Assets.assets.images.box.path,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.orders);
            },
          ),

          ProfileOptionsList(
            text: 'المفضلة',
            image: Assets.assets.images.heart.path,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.favorite);
            },
          ),
        ],
      ),
    );
  }
}