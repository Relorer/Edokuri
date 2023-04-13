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
    List<Object?> voices = await FlutterTts().getVoices;
    return TTSController(session, voices);
  }
}

class TTSController {
  final AudioSession session;
  final SettingsController settingsController = getIt<SettingsController>();
  final FlutterTts tts = FlutterTts();
  late List<Object?> voices;

  bool isSlowing = true;
  late String previousVoicedText = "";

  TTSController(this.session, this.voices) {
    tts.setCompletionHandler(() {
      session.setActive(false);
    });
    tts.setLanguage("en-US");
  }

  void speak(String text) async {
    setVoice(settingsController.voice);
    if (await session.setActive(
      true,
    )) {
      determineSpeed(text);
      await tts.speak(text);
    }
  }

  void setVoice(String value) {
    Object? voice = getIt<TTSController>()
        .voices
        .firstWhere((e) => (e as Map)["name"].toString() == value);
    Map<String, String> voiceMap = {
      "name": (voice as Map)["name"],
      "locale": (voice)["locale"]
    };
    tts.setVoice(voiceMap);
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
