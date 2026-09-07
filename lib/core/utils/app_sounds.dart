import 'package:audioplayers/audioplayers.dart';

class AppSounds {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playClickSound(String sound) async {
    await _player.setVolume(0.1);
    await _player.play(
      AssetSource('songs/$sound'),
    );
  }
}