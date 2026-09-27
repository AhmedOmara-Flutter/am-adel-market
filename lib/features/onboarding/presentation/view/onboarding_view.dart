import 'package:flutter/services.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3DFBA),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            final cubit = context.read<MainCubit>();
            if (cubit.currentIndex != 0) {
              cubit.changeBottomNav(0);
            } else {
              SystemNavigator.pop();
            }
          },

          child: OnBoardingViewBody(),
        ),
      ),
    );
  }
}
