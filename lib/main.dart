import 'dart:async';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'
as crashlytics;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initAppModule();
  Bloc.observer = BlocObserverReader();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final isCrashlyticsSupported = !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  if (isCrashlyticsSupported) {
    FlutterError.onError = (FlutterErrorDetails details) {
      unawaited(
        crashlytics.FirebaseCrashlytics.instance
            .recordFlutterFatalError(details),
      );
    };

    PlatformDispatcher.instance.onError = (error, stackTrace) {
      unawaited(
        crashlytics.FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          fatal: true,
        ),
      );
      return true;
    };
  }

  await Supabase.initialize(
    url: 'https://iwpajzhxqoniotvcwdwc.supabase.co',
    publishableKey : 'sb_publishable_H-Yl3IPOSuUp3krL4tOOPA_uG8OIx_A',
  );

  await CacheHelper.init();

  Constants.onBoarding =
      await CacheHelper.getData(key: 'onBoarding') ?? false;

  Constants.uId = await CacheHelper.getData(key: 'uId') ?? '';

  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await FirebaseAnalytics.instance.logAppOpen();
  }

  runApp(const MyApp());
}
