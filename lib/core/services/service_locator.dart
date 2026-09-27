import 'package:am_adel_market/core/repos/order_repo/order_repo.dart';
import 'package:am_adel_market/core/repos/product_repo/product_repo.dart';
import 'package:am_adel_market/core/repos/product_repo/product_repo_impl.dart';
import 'package:am_adel_market/core/services/storage_services.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/coupon/data/repos/coupon_repo.dart';
import '../../features/category/data/repos/category_repo.dart';
import '../../features/category/domain/repos/category_repo_impl.dart';
import '../../features/coupon/domain/repos/coupon_repo_impl.dart';
import '../../features/favorite/app/repos/favorite_repo_impl.dart';
import '../../features/favorite/domain/repos/favorite_repo.dart';
import '../../features/restaurant_status/data/repos/restaurant_status_repo.dart';
import '../../features/restaurant_status/domain/repos/restaurant_status_repo_impl.dart';
import '../../features/reviews/data/repos/review_repo_impl.dart';
import '../../features/reviews/domain/repos/review_repo.dart';
import '../repos/bundle_offer_repo/bundle_offer_repo_impl.dart';
import '../repos/bundle_offer_repo/bundle_offer_repo.dart';
import '../repos/cart_repo/cart_repo.dart';
import '../repos/cart_repo/cart_repo_impl.dart';
import '../repos/location_repo/selected_location_repo.dart';
import '../repos/location_repo/selected_location_repo_impl.dart';
import '../repos/offer_repo/offer_repo.dart';
import '../repos/offer_repo/offer_repo_impl.dart';
import '../repos/order_repo/order_repo_impl.dart';
import '../repos/upload_image_repo/upload_image_repo.dart';
import '../repos/upload_image_repo/upload_image_repo_impl.dart';

final instance = GetIt.instance;

void initAppModule() {
  instance.registerLazySingleton<AuthServices>(
        () => AuthWithFirebase(),
  );
  instance.registerLazySingleton<DatabaseServices>(() => FirestoreDatabase());
  instance.registerLazySingleton<StorageServices>(() => SupabaseStorage());
  instance.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(instance(), instance()),
  );

  instance.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(instance()),
  );

  instance.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoImpl(instance()),
  );
  instance.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(instance()),
  );

  instance.registerLazySingleton<ReviewRepo>(
        () => ReviewRepoImpl(instance()),
  );
  instance.registerLazySingleton<OfferRepo>(
        () => OfferRepoImpl(instance()),
  );
  instance.registerLazySingleton<UploadImageRepo>(
        () => UploadImageRepoImpl(instance()),
  );
  instance.registerLazySingleton<CartRepo>(
        () => CartRepoImpl(instance()),
  );
  instance.registerLazySingleton<BundleOfferRepo>(
        () => BundleOfferRepoImpl(instance()),
  );
  instance.registerLazySingleton<SelectedLocationRepo>(
        () => SelectedLocationRepoImpl(instance()),
  );
  instance.registerLazySingleton<CategoryRepo>(
        () => CategoryRepoImpl(instance()),
  );
  instance.registerLazySingleton<RestaurantStatusRepo>(
        () => RestaurantStatusRepoImpl(instance()),
  );
  instance.registerLazySingleton<CouponRepo>(
        () => CouponRepoImpl(instance()),
  );
}
