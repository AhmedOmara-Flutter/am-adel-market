import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/helper_function/make_full_name.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/offers/presentation/view_model/offer_cubit.dart';

import '../../../../core/helper_function/get_greeting.dart';
import 'custom_search_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = context
        .watch<OfferCubit>()
        .offers
        .where((e) => e.isActive)
        .toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              context.read<MainCubit>().changeBottomNav(3);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.border, width: 2.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.35),
                    blurRadius: 15.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  Assets.assets.images.customer.path,
                  width: 68.w,
                  height: 68.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(width: 15.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${getGreeting()}  ",
                        style: StyleManager.font13Weight600.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: "👋",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  makeFullName(getUser().userName),
                  style: StyleManager.font16Weight700.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          if (offers.isNotEmpty)
            CustomSearchButton()        ],
      ),
    );
  }
}
