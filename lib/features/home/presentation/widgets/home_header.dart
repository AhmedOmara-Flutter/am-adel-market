import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/helper_function/make_full_name.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/resto_kit.dart';
import 'package:am_adel_market/features/offers/presentation/view_model/offer_cubit.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as crashlytics;

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
          // الصورة الشخصية: حلقة ذهبية مزدوجة
          RestoPressScale(
            pressedScale: .94,
            onTap: () => context.read<MainCubit>().changeBottomNav(3),
            child: Container(
              width: 74.w,
              height: 74.w,
              padding: EdgeInsets.all(2.5.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: Resto.gold,
                boxShadow: Resto.shadow(alpha: .20, blur: 14, dy: 6),
              ),
              child: Container(
                padding: EdgeInsets.all(2.5.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.cardLight,
                ),
                child: ClipOval(
                  child: Image.asset(
                    Assets.assets.images.customer.path,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${getGreeting()}  ",
                        style: StyleManager.font13Weight600.copyWith(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      TextSpan(
                        text: "👋",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  makeFullName(getUser().userName),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font16Weight700.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6.h),
                SizedBox(width: 76.w, child: const RestoDivider(compact: true)),
              ],
            ),
          ),

          if (offers.isNotEmpty) CustomSearchButton(),
        ],
      ),
    );
  }
}