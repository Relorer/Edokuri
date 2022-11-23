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
    final connectivityResult = await (Connectivity().checkConnectivity());
    final hasInterner = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

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

      var yaResult = hasInterner
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
          hasInterner ? await gService.translate(content) : "";

      translations.add(googleTranslate.isNotEmpty
          ? Translation(googleTranslate, source: googleSource)
          : Translation(await _translator.translateText(content),
              source: googleSource));
    }

    return Record(
        original: content,
        transcription: transcription,
        synonyms: synonyms,
        sentences: [],
        known: false,
        creationDate: DateTime.now())
      ..meanings.addAll(meanings)
      ..examples.addAll(examples)
      ..translations.addAll(translations);
  }
}
