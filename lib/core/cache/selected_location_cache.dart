import '../../features/checkout/domain/entities/selected_location_entity.dart';

class SelectedLocationCache {
  List<SelectedLocationEntity>? locations;
  int? version;

  bool get hasData => locations != null;

  void save({
    required List<SelectedLocationEntity> locations,
    required int version,
  }) {
    this.locations = locations;
    this.version = version;
  }

  void clear() {
    locations = null;
    version = null;
  }
}