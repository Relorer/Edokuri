// 📦 Package imports:
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/translator.dart';

class MLGoogleTranslator implements Translator {
  TranslateLanguage? _sourceLanguage;
  TranslateLanguage? _targetLanguage;

  late OnDeviceTranslator _translator;

  MLGoogleTranslator();

  @override
  bool get needInternet => false;

  @override
  Future<List<String>> translate(String word, String from, String to) async {
    if (_sourceLanguage != getLanguage(from) ||
        _targetLanguage != getLanguage(to)) {
      _sourceLanguage = getLanguage(from);
      _targetLanguage = getLanguage(to);
      _translator = OnDeviceTranslator(
          sourceLanguage: _sourceLanguage!, targetLanguage: _targetLanguage!);
    }

    return <String>[await _translator.translateText(word)];
  }

  TranslateLanguage getLanguage(String lang) {
    switch (lang) {
      case "en":
        return TranslateLanguage.english;
      case "ru":
        return TranslateLanguage.russian;
      default:
        return TranslateLanguage.english;
    }
  }

  @override
  String get source => googleMlSource;
}
