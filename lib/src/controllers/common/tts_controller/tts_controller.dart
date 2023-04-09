// 🎯 Dart imports:

// 📦 Package imports:
import 'package:audio_session/audio_session.dart';
import 'package:flutter_tts/flutter_tts.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';

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
  final SettingsController settingsController = getIt<SettingsController>();
  final FlutterTts tts = FlutterTts();

  bool isSlowing = true;
  late String previousVoicedText = "";

  TTSController(this.session) {
    tts.setCompletionHandler(() {
      session.setActive(false);
    });
    tts.setLanguage("en-US");
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
      await tts.setSpeechRate(settingsController.ttsMinRate);
      isSlowing = false;
    } else {
      previousVoicedText = text;
      await tts.setSpeechRate(settingsController.ttsMaxRate);
      isSlowing = true;
    }
  }
}
