import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freader/src/controllers/common/translator_controller/services/google_translator_service.dart';
import 'package:freader/src/controllers/common/translator_controller/services/msa_dictionary_service.dart';
import 'package:freader/src/controllers/common/translator_controller/services/yandex_dictionary_service.dart';
import 'package:freader/src/controllers/common/translator_controller/translate_source.dart';
import 'package:freader/src/models/record.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

const maxPhraseLength = 30;

class TranslatorController {
  final MSADictionaryService msaDicService = MSADictionaryService();
  final OnDeviceTranslator _translator;
  final YandexDictionaryService yaDicService = YandexDictionaryService();
  final GoogleTranslatorService gService = GoogleTranslatorService();

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

      var msaResult = msaDicService.lookup(contentLowerCase).then((value) {
        meanings = value.meanings;
        synonyms = value.synonyms;
        synonyms.removeWhere(
            (element) => element.toLowerCase() == contentLowerCase);
      });

      var yaResult = hasInternet
          ? yaDicService.lookup(contentLowerCase).then((value) {
              translations = value.translations;
              examples = value.examples;
              transcription = value.transcription;
            })
          : Future(() => null);

      await Future.wait([msaResult, yaResult]);
    }

    if (translations.isEmpty) {
      final googleTranslate =
          hasInternet ? await gService.translate(content) : "";

      translations.add(googleTranslate.isNotEmpty
          ? Translation(googleTranslate, source: googleSource)
          : Translation(await _translator.translateText(content),
              source: googleSource));
    }

    return Record(
        original: content,
        originalLowerCase: content.toLowerCase(),
        transcription: transcription,
        synonyms: synonyms,
        known: false,
        creationDate: DateTime.now(),
        lastReview: DateTime(0),
        timeToNextReview: 0)
      ..meanings.addAll(meanings)
      ..examples.addAll(examples)
      ..translations.addAll(translations);
  }

  Future<String> translateSentence(String sentence) async {
    final hasInternet = await _hasInternet();

    sentence = sentence.trim();

    final googleTranslate =
        hasInternet ? await gService.translate(sentence) : "";

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
