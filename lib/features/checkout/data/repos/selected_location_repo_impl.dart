import 'package:am_adel_market/features/checkout/domain/repos/selected_location_repo.dart';

import '../../../../../../core/cache/selected_location_cache.dart';
import '../../domain/entities/selected_location_entity.dart';
import '../models/selected_location_model.dart';
import '../../../../../../core/services/database_services.dart';

class SelectedLocationRepoImpl implements SelectedLocationRepo {
  final DatabaseServices _databaseServices;
  final SelectedLocationCache _locationCache;

  Future<List<SelectedLocationEntity>>? _locationsLoading;

  SelectedLocationRepoImpl(
      this._databaseServices,
      this._locationCache,
      );

  static const String _collection = 'delivery_locations';

  @override
  Stream<List<SelectedLocationEntity>> getLocationsStream() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: 'app_settings',
        uId: 'cache_versions',
      )) {
        print('📡 DELIVERY LOCATIONS VERSION STREAM TRIGGERED');

        if (data == null) {
          print('⚠️ DELIVERY LOCATIONS VERSION DATA IS NULL');
          continue;
        }

        final versionData = Map<String, dynamic>.from(data as Map);

        final int? firebaseVersion =
        (versionData['deliveryLocationsVersion'] as num?)?.toInt();

        print(
          '🔥 FIRESTORE DELIVERY LOCATIONS VERSION: '
              '$firebaseVersion',
        );

        print(
          '💾 LOCAL DELIVERY LOCATIONS CACHE VERSION: '
              '${_locationCache.version}',
        );

        if (firebaseVersion == null) {
          print('⚠️ DELIVERY LOCATIONS VERSION IS NULL');
          continue;
        }

        if (_locationCache.hasData &&
            _locationCache.version == firebaseVersion) {
          print('🟢 DELIVERY LOCATIONS FROM CACHE');

          print(
            '📦 CACHED DELIVERY LOCATIONS COUNT: '
                '${_locationCache.locations!.length}',
          );

          yield _locationCache.locations!;
          continue;
        }

        print('🟡 DELIVERY LOCATIONS CACHE MISS');

        final locations =
        await (_locationsLoading ??= _loadLocations(
          firebaseVersion,
        ));

        print('✅ DELIVERY LOCATIONS LOADED');
        print(
          '📦 DELIVERY LOCATIONS COUNT: ${locations.length}',
        );

        yield locations;
      }
    } catch (e) {
      print('❌ getLocationsStream error: $e');

      throw Exception(e.toString());
    }
  }

  Future<List<SelectedLocationEntity>> _loadLocations(
      int version,
      ) async
  {
    try {
      print('🔴 READING DELIVERY LOCATIONS FROM FIRESTORE');

      final data =
      await _databaseServices.getData(
        path: _collection,
        query: {
          'orderBy': 'createdAt',
          'descending': false,
        },
      )
      as List<Map<String, dynamic>>;

      print('🔥 DELIVERY LOCATIONS FIRESTORE READ');
      print('📦 DELIVERY LOCATIONS COUNT: ${data.length}');

      final locations = data
          .map(
            (json) => SelectedLocationModel.fromJson(json).toEntity(),
      )
          .toList();

      _locationCache.save(
        locations: locations,
        version: version,
      );

      print('💾 DELIVERY LOCATIONS SAVED TO CACHE');
      print(
        '💾 DELIVERY LOCATIONS CACHE VERSION: '
            '${_locationCache.version}',
      );

      return locations;
    } finally {
      _locationsLoading = null;
    }
  }

  @override
  Future<String> addLocation(
      SelectedLocationEntity location,
      ) async {
    final model = SelectedLocationModel.fromEntity(location);

    return await _databaseServices.addData(
      path: _collection,
      data: model.toJson(),
    );
  }

  @override
  Future<void> updateLocation(
      SelectedLocationEntity location,
      ) async {
    final model = SelectedLocationModel.fromEntity(location);

    await _databaseServices.updateData(
      path: _collection,
      docId: location.id,
      data: model.toJson(),
    );
  }

  @override
  Future<void> deleteLocation(
      String id,
      ) async {
    await _databaseServices.deleteData(
      path: _collection,
      uId: id,
    );
  }

  @override
  Future<bool> checkLocationExists(
      String id,
      ) async {
    return await _databaseServices.checkExists(
      path: _collection,
      uId: id,
    );
  }
}