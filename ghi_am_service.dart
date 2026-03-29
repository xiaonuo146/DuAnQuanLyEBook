import 'package:speech_to_text/speech_to_text.dart';

class GhiAmService {
  final SpeechToText speech = SpeechToText();

  Future<bool> init() async {
    return await speech.initialize();
  }

  void start(Function(String) onResult) async {
    await speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
      localeId: "vi_VN",
    );
  }

  void stop() async {
    await speech.stop();
  }
}