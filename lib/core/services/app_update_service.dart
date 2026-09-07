import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdateService {
  AppUpdateService();

  final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      // لو الإنترنت مش موجود أو حصل Timeout
      // التطبيق يكمل عادي بالـ cached values
      print('Remote Config Error: $e');
    }
  }

  Future<bool> isForceUpdateRequired() async {
    final packageInfo = await PackageInfo.fromPlatform();

    final currentVersion = packageInfo.version;

    final minimumVersion =
    _remoteConfig.getString('minimum_version');

    if (minimumVersion.isEmpty) {
      return false;
    }

    return _compareVersions(
      currentVersion,
      minimumVersion,
    ) <
        0;
  }

  String get latestVersion {
    return _remoteConfig.getString('latest_version');
  }

  String get downloadUrl {
    return _remoteConfig.getString('download_url');
  }

  int _compareVersions(
      String current,
      String minimum,
      ) {
    final currentParts = current.split('.');
    final minimumParts = minimum.split('.');

    final maxLength = currentParts.length > minimumParts.length
        ? currentParts.length
        : minimumParts.length;

    for (int i = 0; i < maxLength; i++) {
      final currentNumber = i < currentParts.length
          ? int.tryParse(currentParts[i]) ?? 0
          : 0;

      final minimumNumber = i < minimumParts.length
          ? int.tryParse(minimumParts[i]) ?? 0
          : 0;

      if (currentNumber != minimumNumber) {
        return currentNumber.compareTo(minimumNumber);
      }
    }

    return 0;
  }
}