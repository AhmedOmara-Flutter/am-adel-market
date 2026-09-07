import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../services/database_services.dart';
import '../../entities/offer_entity.dart';
import 'offer_repo.dart';
import '../../models/offer_model.dart';

class OfferRepoImpl implements OfferRepo {
  final DatabaseServices _databaseServices;

  OfferRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, void>> addOffer(OfferEntity offer) async {
    try {
      final result = await _databaseServices.addData(
        path: 'offers',
        data: OfferModel.fromEntity(offer).toJson(),
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOffer(String offerId) async {
    try {
      final res = await _databaseServices.deleteData(
          path: 'offers', uId: offerId);
      return Right(res);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<OfferEntity>>> getOffers() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>) in _databaseServices
          .getStreamData(path: 'offers')) {
        List<OfferEntity> offers = data
            .map((e) => OfferModel.fromJson(e).toEntity())
            .toList();
        print('All offers count: ${offers.length}');
        // final now = DateTime.now();
        // offers = offers.where((offer) {
        //   return !offer.startDate.isAfter(now) &&
        //       !offer.endDate.isBefore(now);
        // }).toList();
        //
        // offers = offers.where((offer) => offer.isActive).toList();
        yield Right(offers);
      }
    } on Exception catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateOffer(OfferEntity offer) {
    // TODO: implement updateOffer
    throw UnimplementedError();
  }
}
