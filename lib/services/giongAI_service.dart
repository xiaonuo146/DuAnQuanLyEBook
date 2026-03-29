import 'package:flutter_tts/flutter_tts.dart';

class giongAI {
  final FlutterTts tts = FlutterTts();

  Future<void> init() async {
    await tts.setLanguage("vi-VN");
    await tts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    await tts.stop(); // tránh chồng tiếng
    await tts.speak(text);
  }

  Future<void> stop() async {
    await tts.stop();
  }
}