import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freader/src/models/record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YandexPartOfRecord {
  List<Translation> translations;
  List<Example> examples;

  YandexPartOfRecord({
    required this.translations,
    required this.examples,
  });
}

class YandexDictionaryService {
  Future<YandexPartOfRecord> lookup(String word) async {
    List<Translation> translations = [];
    List<Example> examples = [];

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      var ur = Uri.parse(
          "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=${dotenv.env['YANDEX_DICTIONARY_KEY']}&lang=en-ru&text=$word");
      final result = await http.get(ur);

      if (result.statusCode == 200) {
        final parsedJson = jsonDecode(result.body);

        for (var def in parsedJson["def"] ?? []) {
          for (var tr in def["tr"] ?? []) {
            translations.add(Translation(tr["text"]));
            for (var syn in tr["syn"] ?? []) {
              translations.add(Translation(syn["text"]));
            }
            for (var ex in tr["ex"] ?? []) {
              examples.add(Example(ex["text"], ex["tr"][0]["text"]));
            }
          }
        }
      }
    }

    return YandexPartOfRecord(translations: translations, examples: examples);
  }
}
