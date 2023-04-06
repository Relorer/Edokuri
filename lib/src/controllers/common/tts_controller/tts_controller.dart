// 🎯 Dart imports:

// 📦 Package imports:
import 'package:audio_session/audio_session.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSControllerFactory {
  Future<TTSController> getTTSController() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech().copyWith(
        androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransient));

    return TTSController(session);
  }
}

class TTSController {
  final AudioSession session;

  final FlutterTts tts = FlutterTts();

  bool isSlowing = true;
  late String previousVoicedText = "";
  final double normalRate = 0.5;
  final double slowedRate = 0.1;

  TTSController(this.session) {
    tts.setCompletionHandler(() {
      session.setActive(false);
    });
  }

  void speak(String text) async {
    if (await session.setActive(
      true,
    )) {
      determineSpeed(text);
      await tts.speak(text);
    }
  }

  void determineSpeed(String text) async {
    if (previousVoicedText == text && isSlowing) {
      await tts.setSpeechRate(slowedRate);
      isSlowing = false;
    } else {
      previousVoicedText = text;
      await tts.setSpeechRate(normalRate);
      isSlowing = true;
    }
  }
}
