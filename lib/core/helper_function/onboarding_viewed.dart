import '../services/cache_helper.dart';

void onBoardingViewed() async {
  await CacheHelper.saveData(key: 'onBoarding', value: true);
}
