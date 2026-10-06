
import '../../features/flash_offers/domain/entities/flash_offer_entity.dart';

class FlashOfferCache {
  List<FlashOfferEntity>? flashOffers;
  int? version;

  bool get hasData =>
      flashOffers != null && flashOffers!.isNotEmpty;

  void save({
    required List<FlashOfferEntity> flashOffers,
    required int version,
  }) {
    this.flashOffers = flashOffers;
    this.version = version;
  }

  void clear() {
    flashOffers = null;
    version = null;
  }
}