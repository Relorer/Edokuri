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

  TranslatorControllerBase(this._translator);

  Future<Record> translate(String content, String sentence) async {
    content = content.toLowerCase().trim();

    List<Translation> translations = [];
    List<Meaning> meanings = [];
    List<String> synonyms = [];
    List<Example> examples = [];

    if (!content.contains(" ")) {
      final yaResult = await yaDicService.lookup(content);
      final msaResult = await msaDicService.lookup(content);

      translations = yaResult.translations;
      examples = yaResult.examples;
      synonyms = msaResult.synonyms;
      meanings = msaResult.meanings;

      synonyms.removeWhere((element) => element.toLowerCase() == content);
    }

    if (translations.isEmpty) {
      translations.add(Translation(await _translator.translateText(content)));
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
