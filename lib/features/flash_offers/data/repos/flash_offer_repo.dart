import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/flash_offer_entity.dart';

abstract class FlashOfferRepo {
  Stream<Either<Failure, List<FlashOfferEntity>>> getFlashOffers();

}