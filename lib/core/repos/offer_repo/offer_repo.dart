import 'package:dartz/dartz.dart';
import '../../errors/failure.dart';
import '../../entities/offer_entity.dart';

abstract class OfferRepo {
  Future<Either<Failure, void>> addOffer(OfferEntity offer,);

  Stream<Either<Failure, List<OfferEntity>>> getOffers();

  Future<Either<Failure, void>> deleteOffer(String offerId,);

  Future<Either<Failure, void>> updateOffer(OfferEntity offer,);
}
