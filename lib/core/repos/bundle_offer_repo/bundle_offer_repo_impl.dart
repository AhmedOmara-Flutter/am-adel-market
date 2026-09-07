import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/entities/bundle_offer_entity.dart';
import 'package:am_adel_market/core/errors/failure.dart';
import 'package:am_adel_market/core/services/database_services.dart';

import '../../models/bundle_offer_model.dart';
import 'bundle_offer_repo.dart';

class BundleOfferRepoImpl implements BundleOfferRepo {
  final DatabaseServices _databaseServices;

  BundleOfferRepoImpl(this._databaseServices);

  @override
  Stream<Either<Failure, List<BundleOfferEntity>>> getBundleOffers() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
          in _databaseServices.getStreamData(path: 'bundle_offers')) {
        List<BundleOfferEntity> offers = data
            .map((e) => BundleOfferModel.fromJson(e).toEntity())
            .toList();
        yield Right(offers);
      }
    } on Exception catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
