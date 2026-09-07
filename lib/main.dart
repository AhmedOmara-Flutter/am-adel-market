import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/services/app_update_service.dart';
import 'core/services/notification_services.dart';
import 'features/updates/presentation/view/force_update_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  Bloc.observer = BlocObserverReader();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final appUpdateService = AppUpdateService();
  // await appUpdateService.initialize();
  // final forceUpdate =
  // await appUpdateService.isForceUpdateRequired();
  await Supabase.initialize(
    url: 'https://cvjjkzcisgbwgxvyiikx.supabase.co',
    anonKey: 'sb_publishable_EpubB_aTdpc4UY7EjRvTEg_ujLCSIJd',
  );
  await CacheHelper.init();
  Constants.onBoarding = await CacheHelper.getData(key: 'onBoarding') ?? false;
  Constants.uId = await CacheHelper.getData(key: 'uId') ?? '';
  // await NotificationServices.initLocal();
  // await NotificationServices.initFirebase();
  // if (forceUpdate) {
  //   runApp(
  //     ForceUpdateView(
  //       downloadUrl: appUpdateService.downloadUrl,
  //     ),
  //   );
  //
  //   return;
  // }
  runApp(const MyApp());
}