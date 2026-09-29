import '../entities/bundle_offer_entity.dart';

class BundleOfferCache {
  List<BundleOfferEntity>? bundleOffers;
  int? version;

  bool get hasData => bundleOffers != null;

  void save({
    required List<BundleOfferEntity> bundleOffers,
    required int version,
  }) {
    this.bundleOffers = bundleOffers;
    this.version = version;
  }

  void clear() {
    bundleOffers = null;
    version = null;
  }
}
