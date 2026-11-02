import 'package:dartz/dartz.dart';

import '../../../../core/cache/offer_cache.dart';
import '../../domain/entities/offer_entity.dart';
import '../../../../core/errors/failure.dart';
import '../models/offer_model.dart';
import '../../../../core/services/database_services.dart';
import '../../domain/repos/offer_repo.dart';

class OfferRepoImpl implements OfferRepo {
  final DatabaseServices _databaseServices;
  final OfferCache _offerCache;

  Future<List<OfferEntity>>? _offersLoading;

  OfferRepoImpl(
      this._databaseServices,
      this._offerCache,
      );

  @override
  Future<Either<Failure, void>> addOffer(
      OfferEntity offer,
      ) async {
    try {
      final result = await _databaseServices.addData(
        path: 'offers',
        data: OfferModel.fromEntity(offer).toJson(),
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteOffer(
      String offerId,
      ) async {
    try {
      final res = await _databaseServices.deleteData(
        path: 'offers',
        uId: offerId,
      );

      return Right(res);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Stream<Either<Failure, List<OfferEntity>>> getOffers() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: 'app_settings',
        uId: 'cache_versions',
      )) {
        print('📡 OFFERS VERSION STREAM TRIGGERED');

        if (data == null) {
          print('⚠️ OFFERS VERSION DATA IS NULL');
          continue;
        }

        final versionData = Map<String, dynamic>.from(data as Map);

        final int? firebaseVersion =
        (versionData['offersVersion'] as num?)?.toInt();

        print(
          '🔥 FIRESTORE OFFERS VERSION: $firebaseVersion',
        );

        print(
          '💾 LOCAL OFFERS CACHE VERSION: '
              '${_offerCache.version}',
        );

        if (firebaseVersion == null) {
          print('⚠️ OFFERS VERSION IS NULL');
          continue;
        }

        if (_offerCache.hasData &&
            _offerCache.version == firebaseVersion) {
          print('🟢 OFFERS FROM CACHE');

          print(
            '📦 CACHED OFFERS COUNT: '
                '${_offerCache.offers!.length}',
          );

          yield Right(_offerCache.offers!);
          continue;
        }

        print('🟡 OFFERS CACHE MISS');

        final offers = await (_offersLoading ??= _loadOffers(
          firebaseVersion,
        ));

        print('✅ OFFERS LOADED');
        print('📦 OFFERS COUNT: ${offers.length}');

        yield Right(offers);
      }
    } catch (e) {
      print('❌ getOffers error: $e');

      yield Left(
        ServerFailure(
          errMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<List<OfferEntity>> _loadOffers(
      int version,
      ) async {
    try {
      print('🔴 READING OFFERS FROM FIRESTORE');

      final data =
      await _databaseServices.getData(
        path: 'offers',
      )
      as List<Map<String, dynamic>>;

      print('🔥 OFFERS FIRESTORE READ');
      print('📦 OFFERS COUNT: ${data.length}');

      final offers = data
          .map(
            (e) => OfferModel.fromJson(e).toEntity(),
      )
          .toList();

      _offerCache.save(
        offers: offers,
        version: version,
      );

      print('💾 OFFERS SAVED TO CACHE');

      print(
        '💾 OFFERS CACHE VERSION: '
            '${_offerCache.version}',
      );

      return offers;
    } finally {
      _offersLoading = null;
    }
  }

  @override
  Future<Either<Failure, void>> updateOffer(
      OfferEntity offer,
      ) async {
    throw UnimplementedError();
  }
}