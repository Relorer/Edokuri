// Package imports:
import 'package:text_to_speech/text_to_speech.dart';

class TTSController {
  TextToSpeech tts = TextToSpeech();

  void speak(String text) {
    tts.speak(text);
  }
}
