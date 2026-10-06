import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/no_internet_view.dart';
import 'package:am_adel_market/features/home/presentation/view_model/best_selling_cubit.dart';
import 'package:am_adel_market/features/home/presentation/view_model/featured_cubit.dart';
import 'package:am_adel_market/features/profile/presentation/view_model/profile_cubit.dart';

import '../../features/bundle_offer/view_model/get_bundle_offer_cubit/get_bundle_offer_cubit.dart';
import '../../features/cart/presentation/view_model/cart_cubit.dart';
import '../../features/category/presentation/view_model/category_cubit.dart';
import '../../features/coupon/presentation/view_model/coupons_cubit.dart';
import '../../features/favorite/presentation/view_model/favorite_cubit.dart';
import '../../features/flash_offers/presentation/view_model/get_flash_offer_cubit/get_flash_offer_cubit.dart';
import '../../features/offers/presentation/view_model/offer_cubit.dart';
import '../../features/restaurant_status/presentation/view_model/restaurant_status_cubit.dart';
import '../../features/reviews/presentation/view_model/add_review_cubit/add_review_cubit.dart';
import '../../features/reviews/presentation/view_model/get_review_cubit/get_review_cubit.dart';
import '../cubit/network_cubit/network_cubit.dart';
import '../cubit/product_cubit/product_cubit.dart';
import '../cubit/selected_coupon_cubit/selected_coupon_cubit.dart';
import '../utils/navigation_key.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NetworkCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => BestSellingCubit(instance())),
        BlocProvider(create: (context) => FeaturedCubit(instance())),
        BlocProvider(create: (context) => ProductCubit(instance())),
        BlocProvider(create: (context) => CartCubit(instance())),
        BlocProvider(create: (context) => FavoriteCubit(instance())..getFavorites(),),
        BlocProvider(
          create: (context) =>
              ProfileCubit(instance(), instance())..getOrders(),
        ),
        BlocProvider(create: (context) => AddReviewCubit(instance())),
        BlocProvider(create: (context) => GetReviewCubit(instance())),
        BlocProvider(create: (context) => OfferCubit(instance(), instance())),
        BlocProvider(create: (context) => GetBundleOfferCubit(instance())),
        BlocProvider(create: (context) => CategoryCubit(instance())),
        BlocProvider(
          create: (context) =>
              RestaurantStatusCubit(instance())..startListening(),
        ),
        BlocProvider(
          create: (context) =>
              CouponsCubit(instance())..getCoupons(getUser().uId),
        ),
        BlocProvider(create: (_) => SelectedCouponCubit()),
        BlocProvider(create: (_) => GetFlashOfferCubit(instance()),)
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeManager.darkTheme,
            onGenerateRoute: GenerateRoute.generateRoute,
            initialRoute: RouteManager.splash,
            builder: (context, child) {
              return BlocBuilder<NetworkCubit, NetworkState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      child!,
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child:
                            (state is NetworkDisconnected ||
                                state is NetworkLoading)
                            ? const NoInternetView()
                            : const SizedBox.shrink(),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
