import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freader/src/controllers/translator_controller/services/google_translator_service.dart';
import 'package:freader/src/controllers/translator_controller/services/msa_dictionary_service.dart';
import 'package:freader/src/controllers/translator_controller/services/yandex_dictionary_service.dart';
import 'package:freader/src/models/record.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:mobx/mobx.dart';

part 'translator_controller.g.dart';

class TranslatorController = TranslatorControllerBase
    with _$TranslatorController;

abstract class TranslatorControllerBase with Store {
  @observable
  int pageCount = 1;

  final MSADictionaryService msaDicService = MSADictionaryService();
  final OnDeviceTranslator _translator;
  final YandexDictionaryService yaDicService = YandexDictionaryService();
  final GoogleTranslatorService gService = GoogleTranslatorService();

  TranslatorControllerBase(this._translator);

  Future<Record> translate(String content, String sentence) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final hasInterner = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    content = content.trim();

    List<Translation> translations = [];
    List<Meaning> meanings = [];
    List<String> synonyms = [];
    List<Example> examples = [];

    if (!content.contains(" ") || content.length < 30) {
      content = content.toLowerCase();

      var msaResult = msaDicService.lookup(content).then((value) {
        meanings = value.meanings;
        synonyms = value.synonyms;
        synonyms.removeWhere((element) => element.toLowerCase() == content);
      });

      var yaResult = hasInterner
          ? yaDicService.lookup(content).then((value) {
              translations = value.translations;
              examples = value.examples;
            })
          : Future(() => null);

      await Future.wait([msaResult, yaResult]);
    }

    if (translations.isEmpty) {
      final googleTranslate =
          hasInterner ? await gService.translate(content) : "";

      translations.add(googleTranslate.isNotEmpty
          ? Translation(googleTranslate, source: "google")
          : Translation(await _translator.translateText(content),
              source: "google"));
    }

    return Record(
      original: content,
      synonyms: synonyms,
      sentence: sentence,
    )
      ..meanings.addAll(meanings)
      ..examples.addAll(examples)
      ..translations.addAll(translations);
  }
}
