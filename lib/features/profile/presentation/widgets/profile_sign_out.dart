import 'package:am_adel_market/core/helper_function/custom_show_dialog.dart';
import 'package:am_adel_market/core/widgets/loading_page.dart';
import '../../../../core/utils/app_imports.dart';

class ProfileSignOut extends StatelessWidget {
  const ProfileSignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () {
            CustomShowDialog.show(
              context,
              title: 'تسجيل الخروج',
              content: Text(
                'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textSecondary,
                  fontSize: 14.sp,
                ),
              ),
              color: AppColor.red,
              flag: Icons.logout,
              cancel: () => Navigator.pop(context),
              accept: () async {
                await instance<AuthRepo>().signOut();
                context.read<MainCubit>().currentIndex = 0;
                Navigator.pushNamed(
                  context,
                  RouteManager.loading,
                  arguments: const LoadingPageArgs(
                    title: 'جاري تسجيل الخروج...',
                    subTitle: 'برجاء الانتظار لحظات',
                    nextRoute: RouteManager.login,
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 15.h,
            ),
            decoration: BoxDecoration(
              color: AppColor.red.withOpacity(.08),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: AppColor.red.withOpacity(.20),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42.w,
                  height: 35.w,
                  decoration: BoxDecoration(
                    color: AppColor.red.withOpacity(.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    color: AppColor.red,
                    size: 20.sp,
                  ),
                ),

                SizedBox(width: 14.w),

                Expanded(
                  child: Text(
                    'تسجيل الخروج',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColor.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.red.withOpacity(.6),
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}