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
    final allVoices = await FlutterTts().getVoices;
    List<Map<Object?, Object?>> desiredLocaleVoices =
        List.empty(growable: true);
    for (var element in allVoices) {
      (element as Map<Object?, Object?>).forEach((key, value) {
        if (value == "en-US") desiredLocaleVoices.add(element);
      });
    }
    return TTSController(session, desiredLocaleVoices);
  }
}

class TTSController {
  final AudioSession session;
  final SettingsController settingsController = getIt<SettingsController>();
  final FlutterTts tts = FlutterTts();
  bool isSlowing = true;
  late String previousVoicedText = "";
  late List<Map<Object?, Object?>> voices;
  String lastVoice = "";

  TTSController(this.session, this.voices) {
    tts.setCompletionHandler(() {
      session.setActive(false);
    });
    tts.setLanguage("en-US");
  }

  void speak(String text) async {
    String settingsVoice = settingsController.voice;
    if (lastVoice != settingsVoice) {
      setVoice(settingsVoice);
      lastVoice = settingsVoice;
    }
    if (await session.setActive(
      true,
    )) {
      determineSpeed(text);
      await tts.speak(text);
    }
  }

  void setVoice(String value) {
    tts.setVoice(getIt<TTSController>()
        .voices
        .firstWhere((element) => element.values.contains(value))
        .map((key, value) => MapEntry(key.toString(), value.toString())));
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
