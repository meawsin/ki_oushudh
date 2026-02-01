import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final FlutterTts _tts = FlutterTts();

  Future<void> speakBangla(String text) async {
    await _tts.setLanguage("bn-BD");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.4); // Slow for elderly ears
    await _tts.speak(text);
  }

  void stop() => _tts.stop();
}