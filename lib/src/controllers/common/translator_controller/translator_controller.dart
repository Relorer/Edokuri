// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/dictionary/msa_dictionary.dart';
import 'package:edokuri/src/controllers/common/translator_controller/dictionary/yandex_dictionary.dart';
import 'package:edokuri/src/controllers/common/translator_controller/example/oxfordlearnersdictionaries.dart';
import 'package:edokuri/src/controllers/common/translator_controller/forms/local_forms.dart';
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
  final LocalForms _localForms = LocalForms();
  final OxfordLearnersDictionary _oxfordLearnersDictionary =
      OxfordLearnersDictionary();

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
      translations =
          await translateSentence(content, mostPrioritySource: deeplSource)
              .then((value) => value.text
                  .map((e) => Translation(e, source: value.source))
                  .toList());
    }

    final forms = <String>[];
    for (var word in content.split(' ')) {
      forms.addAll(await _localForms.getForms(word));
    }

    if (!content.contains(" ") && examples.isEmpty) {
      final oxf = (await _oxfordLearnersDictionary.fetchExamples(content))
          .take(10)
          .toList();
      final fullText = oxf.join("\n");
      final translateFullText = await translateSentence(fullText);
      final translations = translateFullText.text.first.split("\n");
      for (var i = 0; i < oxf.length; i++) {
        examples
            .add(Example(oxf[i], translations[i], translateFullText.source));
      }
    }

    return Record(
        original: content,
        originalLowerCase: content.toLowerCase(),
        transcription: transcription,
        created: DateTime.utc(0),
        sentences: [],
        synonyms: synonyms,
        forms: forms,
        meanings: meanings,
        examples: examples,
        translations: translations,
        step: RecordStep1(),
        lastReview: DateTime.utc(0));
  }

  Future<TranslateWithSource> translateSentence(String sentence,
      {String mostPrioritySource = ""}) async {
    final hasInternet = await _hasInternet();

    sentence = sentence.trim();

    if (mostPrioritySource.isNotEmpty) {
      try {
        final translate =
            await translateBySource(sentence, mostPrioritySource, hasInternet);

        if (translate.isNotEmpty) {
          return TranslateWithSource(translate, mostPrioritySource);
        }
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");
      }
    }

    for (var o in _settingsController.translatorOrder) {
      try {
        if (o == mostPrioritySource) continue;

        final translate = await translateBySource(sentence, o, hasInternet);

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

  Future<List<String>> translateBySource(
      String sentence, String source, bool hasInternet) async {
    final translator = translators[source];
    if (translator == null) {
      return [];
    }

    if (translator.needInternet && !hasInternet) {
      return [];
    }

    return await translator.translate(sentence, "en", "ru");
  }
}

class TranslateWithSource {
  final List<String> text;
  final String source;

  TranslateWithSource(this.text, this.source);
}
