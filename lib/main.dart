import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  Bloc.observer = BlocObserverReader();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://cvjjkzcisgbwgxvyiikx.supabase.co',
    anonKey: 'sb_publishable_EpubB_aTdpc4UY7EjRvTEg_ujLCSIJd',
  );
  await CacheHelper.init();
  Constants.onBoarding = await CacheHelper.getData(key: 'onBoarding') ?? false;
  Constants.uId = await CacheHelper.getData(key: 'uId') ?? '';
  runApp(const MyApp());
}
