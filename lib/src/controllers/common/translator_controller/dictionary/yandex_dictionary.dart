// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/models/models.dart';

class YandexPartOfRecord {
  List<Translation> translations;
  String transcription;
  List<Example> examples;

  YandexPartOfRecord({
    required this.translations,
    required this.transcription,
    required this.examples,
  });
}

class YandexDictionary {
  Future<YandexPartOfRecord> lookup(String word) async {
    String transcription = "";
    List<Translation> translations = [];
    List<Example> examples = [];

    var ur = Uri.parse(
        "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=${FlutterConfig.get('YANDEX_DICTIONARY_KEY')}&lang=en-ru&text=$word");
    final result = await http.get(ur);

    if (result.statusCode == 200) {
      final parsedJson = jsonDecode(result.body);
      for (var def in parsedJson["def"] ?? []) {
        transcription = def["ts"] ?? "";
        transcription = transcription.isEmpty ? "" : "[$transcription]";
        for (var tr in def["tr"] ?? []) {
          translations.add(Translation(tr["text"], source: yandexSource));
          for (var syn in tr["syn"] ?? []) {
            translations.add(Translation(syn["text"], source: yandexSource));
          }
          for (var ex in tr["ex"] ?? []) {
            examples
                .add(Example(ex["text"], ex["tr"][0]["text"], yandexSource));
          }
        }
      }
    }

    return YandexPartOfRecord(
        translations: translations,
        transcription: transcription,
        examples: examples);
  }
}
