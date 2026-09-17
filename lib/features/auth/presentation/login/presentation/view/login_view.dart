import 'package:flutter/services.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import '../../../../../../core/widgets/loading_overlay.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(instance()),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              AppVibration.medium();
              AppSounds.playClickSound('success.mp3');
              customShowSnakeBar(
                context,
                color: AppColor.green,
                label: 'تم تسجيل الدخول بنجاح',
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteManager.home,
                (route) => false,
                arguments: state.user,
              );
            }
            if (state is LoginError) {
              AppVibration.heavy();
              AppSounds.playClickSound('click_error.wav');

              customShowSnakeBar(
                context,
                color: AppColor.red,
                label: state.errMessage,
              );
            }
          },
          builder: (context, state) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  if (didPop) return;
                  SystemNavigator.pop();
                },
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.assets.images.loginRegisterBg.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      const LoginViewBody(),

                      LoadingOverlay(
                        isLoading: state is LoginLoading,
                        title: 'جاري تسجيل الدخول...',
                        subtitle: 'يرجى الانتظار قليلاً',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
