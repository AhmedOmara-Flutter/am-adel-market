import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:flutter/services.dart';
import '../../../../core/services/notification_services.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    _initializeNotifications();
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    if (!Constants.onBoarding) {
      Navigator.pushReplacementNamed(context, RouteManager.onBoarding);
    } else {
      final isLogged = isLoggedIn();
      Navigator.pushReplacementNamed(
        context,
        isLogged ? RouteManager.home : RouteManager.login,
      );
    }
  }

  Future<void> _initializeNotifications() async {
    try {
      await NotificationServices.initLocal();
      await NotificationServices.initFirebase();

      debugPrint('🟢 Notifications DONE');
    } catch (e) {
      debugPrint('🔴 Notification initialization error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assets.images.splashBg.path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
