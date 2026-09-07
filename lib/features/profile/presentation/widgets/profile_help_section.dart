import 'package:am_adel_market/features/profile/presentation/widgets/profile_option_list.dart';

import '../../../../core/utils/app_imports.dart';

class ProfileHelpSection extends StatelessWidget {
  const ProfileHelpSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'المساعدة',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColor.textSecondary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ProfileOptionsList(
            text: 'من نحن',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.aboutUs);
            },
            image: Assets.assets.images.global.path,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
