import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/errors/failure.dart';
import 'package:am_adel_market/core/services/database_services.dart';
import '../../../../core/cache/flash_offer_cache.dart';
import '../../data/models/flash_offer_model.dart';
import '../../data/repos/flash_offer_repo.dart';
import '../entities/flash_offer_entity.dart';

class FlashOfferRepoImpl implements FlashOfferRepo {
  final DatabaseServices _databaseServices;
  final FlashOfferCache _flashOfferCache;

  Future<List<FlashOfferEntity>>? _flashOffersLoading;

  FlashOfferRepoImpl(
      this._databaseServices,
      this._flashOfferCache,
      );

  @override
  Stream<Either<Failure, List<FlashOfferEntity>>>
  getFlashOffers() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: 'app_settings',
        uId: 'cache_versions',
      )) {
        print('📡 FLASH OFFERS VERSION STREAM TRIGGERED');

        if (data == null) {
          print('⚠️ FLASH OFFERS VERSION DATA IS NULL');
          continue;
        }

        final versionData = Map<String, dynamic>.from(data as Map);

        final int? firebaseVersion =
        (versionData['flashOffersVersion'] as num?)?.toInt();

        print(
          '🔥 FIRESTORE FLASH OFFERS VERSION: $firebaseVersion',
        );

        print(
          '💾 LOCAL FLASH OFFERS CACHE VERSION: '
              '${_flashOfferCache.version}',
        );

        if (firebaseVersion == null) {
          print('⚠️ FLASH OFFERS VERSION IS NULL');
          continue;
        }

        if (_flashOfferCache.hasData &&
            _flashOfferCache.version == firebaseVersion) {
          print('🟢 FLASH OFFERS FROM CACHE');

          print(
            '📦 CACHED FLASH OFFERS COUNT: '
                '${_flashOfferCache.flashOffers!.length}',
          );

          yield Right(_flashOfferCache.flashOffers!);
          continue;
        }

        print('🟡 FLASH OFFERS CACHE MISS');

        final flashOffers =
        await (_flashOffersLoading ??= _loadFlashOffers(
          firebaseVersion,
        ));

        print('✅ FLASH OFFERS LOADED');

        print(
          '📦 FLASH OFFERS COUNT: ${flashOffers.length}',
        );

        yield Right(flashOffers);
      }
    } catch (e) {
      print('❌ getFlashOffers error: $e');

      yield Left(
        ServerFailure(
          errMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<List<FlashOfferEntity>> _loadFlashOffers(
      int version,
      ) async {
    try {
      print('🔴 READING FLASH OFFERS FROM FIRESTORE');

      final data =
      await _databaseServices.getData(
        path: 'flash_offers',
      ) as List<Map<String, dynamic>>;

      print('🔥 FLASH OFFERS FIRESTORE READ');

      print(
        '📦 FLASH OFFERS COUNT: ${data.length}',
      );

      final flashOffers = data
          .map(
            (e) => FlashOfferModel.fromJson(e).toEntity(),
      )
          .toList();

      _flashOfferCache.save(
        flashOffers: flashOffers,
        version: version,
      );

      print('💾 FLASH OFFERS SAVED TO CACHE');

      print(
        '💾 FLASH OFFERS CACHE VERSION: '
            '${_flashOfferCache.version}',
      );

      return flashOffers;
    } finally {
      _flashOffersLoading = null;
    }
  }
}