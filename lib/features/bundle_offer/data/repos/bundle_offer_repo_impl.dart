import 'package:dartz/dartz.dart';
import 'package:am_adel_market/features/bundle_offer/domain/entities/bundle_offer_entity.dart';
import 'package:am_adel_market/core/errors/failure.dart';
import 'package:am_adel_market/core/services/database_services.dart';
import '../../../../core/cache/bundle_offer_cache.dart';
import '../models/bundle_offer_model.dart';
import '../../domain/repos/bundle_offer_repo.dart';

class BundleOfferRepoImpl implements BundleOfferRepo {
  final DatabaseServices _databaseServices;
  final BundleOfferCache _bundleOfferCache;

  Future<List<BundleOfferEntity>>? _bundleOffersLoading;

  BundleOfferRepoImpl(
      this._databaseServices,
      this._bundleOfferCache,
      );

  @override
  Stream<Either<Failure, List<BundleOfferEntity>>>
  getBundleOffers() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: 'app_settings',
        uId: 'cache_versions',
      )) {
        print('📡 BUNDLE OFFERS VERSION STREAM TRIGGERED');

        if (data == null) {
          print('⚠️ BUNDLE OFFERS VERSION DATA IS NULL');
          continue;
        }

        final versionData = Map<String, dynamic>.from(data as Map);

        final int? firebaseVersion =
        (versionData['bundleOffersVersion'] as num?)?.toInt();

        print(
          '🔥 FIRESTORE BUNDLE OFFERS VERSION: $firebaseVersion',
        );
        print(
          '💾 LOCAL BUNDLE OFFERS CACHE VERSION: '
              '${_bundleOfferCache.version}',
        );

        if (firebaseVersion == null) {
          print('⚠️ BUNDLE OFFERS VERSION IS NULL');
          continue;
        }

        if (_bundleOfferCache.hasData &&
            _bundleOfferCache.version == firebaseVersion) {
          print('🟢 BUNDLE OFFERS FROM CACHE');
          print(
            '📦 CACHED BUNDLE OFFERS COUNT: '
                '${_bundleOfferCache.bundleOffers!.length}',
          );

          yield Right(_bundleOfferCache.bundleOffers!);
          continue;
        }

        print('🟡 BUNDLE OFFERS CACHE MISS');

        final bundleOffers =
        await (_bundleOffersLoading ??= _loadBundleOffers(
          firebaseVersion,
        ));

        print('✅ BUNDLE OFFERS LOADED');
        print(
          '📦 BUNDLE OFFERS COUNT: ${bundleOffers.length}',
        );

        yield Right(bundleOffers);
      }
    } catch (e) {
      print('❌ getBundleOffers error: $e');

      yield Left(
        ServerFailure(
          errMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<List<BundleOfferEntity>> _loadBundleOffers(
      int version,
      ) async {
    try {
      print('🔴 READING BUNDLE OFFERS FROM FIRESTORE');

      final data =
      await _databaseServices.getData(
        path: 'bundle_offers',
      )
      as List<Map<String, dynamic>>;

      print('🔥 BUNDLE OFFERS FIRESTORE READ');
      print('📦 BUNDLE OFFERS COUNT: ${data.length}');

      final bundleOffers = data
          .map(
            (e) => BundleOfferModel.fromJson(e).toEntity(),
      )
          .toList();

      _bundleOfferCache.save(
        bundleOffers: bundleOffers,
        version: version,
      );

      print('💾 BUNDLE OFFERS SAVED TO CACHE');
      print(
        '💾 BUNDLE OFFERS CACHE VERSION: '
            '${_bundleOfferCache.version}',
      );

      return bundleOffers;
    } finally {
      _bundleOffersLoading = null;
    }
  }
}