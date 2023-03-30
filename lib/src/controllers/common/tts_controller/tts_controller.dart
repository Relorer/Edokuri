// 📦 Package imports:
import 'dart:developer';
import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:audio_session/audio_session.dart';

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

  TTSController(this.session) {
    tts.setCompletionHandler(() {
      session.setActive(false);
    });
  }

  void speak(String text) async {
    if (await session.setActive(
      true,
    )) {
      await tts.speak(text);
    }
  }
}
