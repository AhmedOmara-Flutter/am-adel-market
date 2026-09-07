import 'package:am_adel_market/core/entities/order_entity.dart';
import 'package:am_adel_market/core/enums/order_enum.dart';
import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/home/presentation/widgets/best_selling_more_view.dart';
import 'package:am_adel_market/features/profile/presentation/view/about_us_view.dart';
import 'package:am_adel_market/features/profile/presentation/view/edit_profile_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/auth/presentation/forget_password/view/forget_password_view.dart';
import '../../features/cart/domain/entities/cart_entity.dart';
import '../../features/checkout/presentation/view/checkout_view.dart';
import '../../features/checkout/presentation/view/payment_success_view.dart';
import '../../features/favorite/presentation/view/favorite_view.dart';
import '../../features/order_tracking/presentation/view/order_tracking_view.dart';
import '../../features/product_details/presentation/view/product_details_view.dart';
import '../../features/profile/presentation/view/orders_view.dart';
import '../../features/reviews/presentation/view/reviews_view.dart';
import '../../features/search/presentation/view/search_view.dart';
import '../widgets/loading_page.dart';

class RouteManager {
  static const String splash = '/splash';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String home = '/main';
  static const String bestSellingMore = '/bestSellingMore';
  static const String productDetails = '/productDetails';
  static const String search = '/search';
  static const String reviews = '/reviews';
  static const String checkout = '/checkout';
  static const String paymentSuccess = '/paymentSuccess';
  static const String orderTracking = '/orderTracking';
  static const String favorite = '/favorite';
  static const String orders = '/orders';
  static const String editProfile = '/editProfile';
  static const String aboutUs = '/aboutUs';
  static const String loading = '/loading';
}

class GenerateRoute {
  static Route<dynamic> _route(Widget child) {
    return PageTransition(
      child: child,
      type: PageTransitionType.fade,
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.splash:
        return _route(const SplashView());

      case RouteManager.onBoarding:
        return _route(const OnBoardingView());

      case RouteManager.login:
        return _route(const LoginView());

      case RouteManager.register:
        return _route(const RegisterView());

      case RouteManager.forgetPassword:
        return _route(const ForgetPasswordView());

      case RouteManager.home:
        return _route(MainView());

      case RouteManager.loading:
        final args = settings.arguments as LoadingPageArgs;

        return _route(LoadingPage(args: args,));

      case RouteManager.editProfile:
        return _route(EditProfileView());

      case RouteManager.bestSellingMore:
        return _route(BestSellingMoreView());

      case RouteManager.productDetails:
        final productId = settings.arguments as String;
        return _route(
          ProductDetailsView(
            productId: productId,
          ),
        );

      case RouteManager.search:
        return _route(SearchView());

      case RouteManager.reviews:
        final productId = settings.arguments as String;
        return _route(
          ReviewsView(
            productId: productId,
          ),
        );

      case RouteManager.checkout:
        return _route(
          CheckoutView(
            orderEntity: OrderEntity(
              cartEntity: settings.arguments as CartEntity,
              uId: getUser().uId,
              userEntity: getUser(),
              status: OrderStatus.pending,
            ),
          ),
        );

      case RouteManager.paymentSuccess:
        final orderEntity = settings.arguments as OrderEntity;
        return _route(
          PaymentSuccessView(
            orderEntity: orderEntity,
          ),
        );

      case RouteManager.orderTracking:
        final orderEntity = settings.arguments as OrderEntity;
        return _route(
          OrderTrackingView(
            orderEntity: orderEntity,
          ),
        );

      case RouteManager.favorite:
        return _route(FavoriteView());

      case RouteManager.orders:
        return _route(OrdersView());

      case RouteManager.aboutUs:
        return _route(AboutUsView());

      default:
        return _route(
            Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 70,
                        color: AppColor.mainColor,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'حدثت مشكلة',
                        style: StyleManager.font23Weight700.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'تعذر إكمال العملية في الوقت الحالي.\nيرجى إغلاق التطبيق وإعادة تشغيله ثم المحاولة مرة أخرى.',
                        textAlign: TextAlign.center,
                        style: StyleManager.font14Weight600.copyWith(
                          color: AppColor.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )

        );
    }
  }
}