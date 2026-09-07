import 'package:vibration/vibration.dart';

class AppVibration {
  static Future<void> light() async {
    Vibration.vibrate(duration: 50);
  }

  static Future<void> medium() async {
    Vibration.vibrate(duration: 150);
  }

  static Future<void> heavy() async {
    Vibration.vibrate(duration: 300);
  }
}
