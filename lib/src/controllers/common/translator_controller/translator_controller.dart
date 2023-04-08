// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/dictionary/msa_dictionary.dart';
import 'package:edokuri/src/controllers/common/translator_controller/dictionary/yandex_dictionary.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/deepl_translator_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/google_translator_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/mlgoogle_translator_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/translator.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step1.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/models.dart';

const maxPhraseLength = 30;

class TranslatorController {
  final SettingsController _settingsController = getIt<SettingsController>();
  final MSADictionary _msaDicService = MSADictionary();
  final YandexDictionary _yaDicService = YandexDictionary();

  final translators = <String, Translator>{};

  TranslatorController(_yaService) {
    translators[googleSource] = Google2Translator();
    translators[googleMlSource] = MLGoogleTranslator();
    translators[yandexSource] = _yaService;
    translators[deeplSource] = DeeplTranslator();
  }

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
      translations = await translateSentence(content).then((value) =>
          value.text.map((e) => Translation(e, source: value.source)).toList());
    }

    return Record(
        original: content,
        originalLowerCase: content.toLowerCase(),
        transcription: transcription,
        creationDate: DateTime.now().toUtc(),
        sentences: [],
        synonyms: synonyms,
        meanings: meanings,
        examples: examples,
        translations: translations,
        step: RecordStep1(),
        lastReview: DateTime.utc(0));
  }

  Future<TranslateWithSource> translateSentence(String sentence) async {
    final hasInternet = await _hasInternet();

    sentence = sentence.trim();

    for (var o in _settingsController.translatorOrder) {
      try {
        final translator = translators[o];
        if (translator == null) {
          continue;
        }

        if (translator.needInternet && !hasInternet) {
          continue;
        }

        final translate = await translator.translate(sentence, "en", "ru");

        if (translate.isNotEmpty) {
          return TranslateWithSource(translate, o);
        }
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");
      }
    }

    return TranslateWithSource(["Couldn't translate"], "");
  }

  Future<bool> _hasInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}

class TranslateWithSource {
  final List<String> text;
  final String source;

  TranslateWithSource(this.text, this.source);
}
