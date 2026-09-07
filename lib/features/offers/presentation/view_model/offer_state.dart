part of 'offer_cubit.dart';

@immutable
sealed class OfferState {}

final class OffersInitial extends OfferState {}
final class OffersLoading extends OfferState {}
final class OffersFailure extends OfferState {
  final String errMessage;
  OffersFailure(this.errMessage);
}
final class OffersSuccess extends OfferState {}

final class GetOffersLoading extends OfferState {}
final class GetOffersEmpty extends OfferState {}
final class  GetOffersFailure extends OfferState {
  final String errMessage;
  GetOffersFailure(this.errMessage);
}
class GetOffersSuccess extends OfferState {
  final List<OfferEntity> offers;
  final Map<String, OfferEntity> offersMap;

  GetOffersSuccess(this.offers, this.offersMap);
}

class DeleteOfferLoading extends OfferState {}
class DeleteOfferSuccess extends OfferState {}
class DeleteOfferFailure extends OfferState {
  final String message;
  DeleteOfferFailure(this.message);
}
