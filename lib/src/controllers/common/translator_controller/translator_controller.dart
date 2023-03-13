// 📦 Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/services/google_translator_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/services/msa_dictionary_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/services/yandex_dictionary_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/models/models.dart';

const maxPhraseLength = 30;

class TranslatorController {
  final MSADictionaryService _msaDicService = MSADictionaryService();
  final OnDeviceTranslator _translator;
  final YandexDictionaryService _yaDicService = YandexDictionaryService();
  final GoogleTranslatorService _gService = GoogleTranslatorService();

  TranslatorController(this._translator);

  Future<Record> translate(String content) async {
    final hasInternet = await _hasInternet();

    content = content.trim();

    var transcription = "";
    List<Translation> translations = [];
    List<Meaning> meanings = [];
    List<String> synonyms = [];
    List<Example> examples = [];

    if (!content.contains(" ") || content.length < maxPhraseLength) {
      final contentLowerCase = content.toLowerCase();

      var msaResult = _msaDicService.lookup(contentLowerCase).then((value) {
        meanings = value.meanings;
        synonyms = value.synonyms;
        synonyms.removeWhere(
            (element) => element.toLowerCase() == contentLowerCase);
      });

      var yaResult = hasInternet
          ? _yaDicService.lookup(contentLowerCase).then((value) {
              translations = value.translations;
              examples = value.examples;
              transcription = value.transcription;
            })
          : Future(() => null);

      await Future.wait([msaResult, yaResult]);
    }

    if (translations.isEmpty) {
      final googleTranslate =
          hasInternet ? await _gService.translate(content) : "";

      translations.add(googleTranslate.isNotEmpty
          ? Translation(googleTranslate, source: googleSource)
          : Translation(await _translator.translateText(content),
              source: googleSource));
    }

    return Record(
        original: content,
        originalLowerCase: content.toLowerCase(),
        transcription: transcription,
        creationDate: DateTime.now(),
        sentences: [],
        synonyms: synonyms,
        meanings: meanings,
        examples: examples,
        translations: translations,
        lastReview: DateTime.utc(0));
  }

  Future<String> translateSentence(String sentence) async {
    final hasInternet = await _hasInternet();

    sentence = sentence.trim();

    final googleTranslate =
        hasInternet ? await _gService.translate(sentence) : "";

    return googleTranslate.isNotEmpty
        ? googleTranslate
        : await _translator.translateText(sentence);
  }

  Future<bool> _hasInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}
