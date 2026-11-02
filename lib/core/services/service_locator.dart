import 'package:am_adel_market/core/cache/flash_offer_cache.dart';
import 'package:am_adel_market/core/repos/order_repo/order_repo.dart';
import 'package:am_adel_market/core/repos/product_repo/product_repo.dart';
import 'package:am_adel_market/core/repos/product_repo/product_repo_impl.dart';
import 'package:am_adel_market/core/services/storage_services.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/coupon/data/repos/coupon_repo.dart';
import 'package:am_adel_market/features/flash_offers/data/repos/flash_offer_repo.dart';
import 'package:am_adel_market/features/flash_offers/domain/repos/flash_offer_repo_impl.dart';
import 'package:am_adel_market/features/order_review/data/repos/order_review_repo.dart';
import 'package:am_adel_market/features/order_review/domain/repos/order_review_repo_impl.dart';
import '../../features/category/data/repos/category_repo.dart';
import '../../features/category/domain/repos/category_repo_impl.dart';
import '../../features/coupon/domain/repos/coupon_repo_impl.dart';
import '../../features/favorite/app/repos/favorite_repo_impl.dart';
import '../../features/favorite/domain/repos/favorite_repo.dart';
import '../../features/order_review/presentation/view_model/order_review_cubit.dart';
import '../../features/restaurant_status/data/repos/restaurant_status_repo.dart';
import '../../features/restaurant_status/domain/repos/restaurant_status_repo_impl.dart';
import '../../features/reviews/data/repos/review_repo_impl.dart';
import '../../features/reviews/domain/repos/review_repo.dart';
import '../cache/bundle_offer_cache.dart';
import '../cache/category_cache.dart';
import '../cache/offer_cache.dart';
import '../cache/product_cache.dart';
import '../cache/selected_location_cache.dart';
import '../../features/bundle_offer/domain/repos/bundle_offer_repo.dart';
import '../../features/bundle_offer/data/repos/bundle_offer_repo_impl.dart';
import '../../features/cart/domain/repos/cart_repo.dart';
import '../../features/cart/data/repos/cart_repo_impl.dart';
import '../../features/checkout/domain/repos/selected_location_repo.dart';
import '../../features/checkout/data/repos/selected_location_repo_impl.dart';
import '../../features/offers/domain/repos/offer_repo.dart';
import '../../features/offers/data/repos/offer_repo_impl.dart';
import '../repos/order_repo/order_repo_impl.dart';
import '../repos/upload_image_repo/upload_image_repo.dart';
import '../repos/upload_image_repo/upload_image_repo_impl.dart';

final instance = GetIt.instance;

void initAppModule() {
  instance.registerLazySingleton<AuthServices>(() => AuthWithFirebase());
  instance.registerLazySingleton<DatabaseServices>(() => FirestoreDatabase());
  instance.registerLazySingleton<StorageServices>(() => SupabaseStorage());
  instance.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(instance(), instance()),
  );
  instance.registerLazySingleton<ProductCache>(() => ProductCache());
  instance.registerLazySingleton<CategoryCache>(() => CategoryCache());
  instance.registerLazySingleton<BundleOfferCache>(() => BundleOfferCache());
  instance.registerLazySingleton<SelectedLocationCache>(
    () => SelectedLocationCache(),
  );
  instance.registerLazySingleton<OfferCache>(() => OfferCache());
  instance.registerLazySingleton<FlashOfferCache>(() => FlashOfferCache());
  instance.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(instance(), instance()),
  );
  instance.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoImpl(instance()),
  );
  instance.registerLazySingleton<OrderRepo>(() => OrderRepoImpl(instance()));
  instance.registerLazySingleton<ReviewRepo>(() => ReviewRepoImpl(instance()));
  instance.registerLazySingleton<OfferRepo>(
    () => OfferRepoImpl(instance(), instance()),
  );
  instance.registerLazySingleton<UploadImageRepo>(
    () => UploadImageRepoImpl(instance()),
  );
  instance.registerLazySingleton<CartRepo>(() => CartRepoImpl(instance()));
  instance.registerLazySingleton<BundleOfferRepo>(
    () => BundleOfferRepoImpl(instance(), instance()),
  );
  instance.registerLazySingleton<SelectedLocationRepo>(
    () => SelectedLocationRepoImpl(instance(), instance()),
  );
  instance.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(instance(), instance()),
  );
  instance.registerLazySingleton<RestaurantStatusRepo>(
    () => RestaurantStatusRepoImpl(instance()),
  );
  instance.registerLazySingleton<OrderReviewRepo>(
    () => OrderReviewRepoImpl(instance()),
  );

  instance.registerFactory<OrderReviewCubit>(
    () => OrderReviewCubit(instance()),
  );

  instance.registerLazySingleton<CouponRepo>(() => CouponRepoImpl(instance()));
  instance.registerLazySingleton<FlashOfferRepo>(
    () => FlashOfferRepoImpl(instance(), instance()),
  );
}
