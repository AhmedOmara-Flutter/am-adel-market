import '../entities/offer_entity.dart';

class OfferCache {
  List<OfferEntity>? offers;
  int? version;

  bool get hasData => offers != null;

  void save({
    required List<OfferEntity> offers,
    required int version,
  }) {
    this.offers = offers;
    this.version = version;
  }

  void clear() {
    offers = null;
    version = null;
  }
}