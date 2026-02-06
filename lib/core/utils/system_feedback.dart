import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SystemFeedback {
  static final AudioPlayer _player = AudioPlayer();
  static final FlutterTts _tts = FlutterTts();

  static Future<void> init() async {
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  static Future<void> success(String message) async {
    await _player.play(AssetSource('sounds/success.mp3'));
    await _tts.speak(message);
  }

  static Future<void> error(String message) async {
    await _player.play(AssetSource('sounds/error.mp3'));
    await _tts.speak(message);
  }
}
