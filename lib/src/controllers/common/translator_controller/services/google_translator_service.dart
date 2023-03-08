// 📦 Package imports:
import 'package:translator/translator.dart';

class GoogleTranslatorService {
  final _translator = GoogleTranslator();

  Future<String> translate(String word) async {
    return (await _translator.translate(word, from: 'en', to: 'ru')).text;
  }
}
