import 'package:dartz/dartz.dart';
import '../../entities/bundle_offer_entity.dart';
import '../../errors/failure.dart';

abstract class BundleOfferRepo {
  Stream<Either<Failure, List<BundleOfferEntity>>> getBundleOffers();
}
