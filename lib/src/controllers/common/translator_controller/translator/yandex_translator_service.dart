// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/translator.dart';
import 'package:edokuri/src/core/service_locator.dart';

const yandexTranslatorServiceKey = "yandexTranslatorServiceKey";

class YandexTranslator implements Translator {
  final Map<String, List<String>> _cache = {};
  String _apiKey;

  YandexTranslator(this._apiKey);

  @override
  bool get needInternet => true;

  @override
  String get source => yandexSource;

  @override
  Future<List<String>> translate(String text, String from, String to) async {
    if (_apiKey.isEmpty) {
      final secureStorage = getIt<FlutterSecureStorage>();
      _apiKey = await secureStorage.read(key: yandexTranslatorServiceKey) ?? "";
      if (_apiKey.isEmpty) {
        return <String>[];
      }
    }

    if (_cache.containsKey(text)) {
      return _cache[text]!;
    }

    try {
      var headers = {
        'Authorization': 'Api-Key $_apiKey',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://translate.api.cloud.yandex.net/translate/v2/translate'));
      request.body = json.encode({
        "target_language_code": to,
        "source_language_code": from,
        "texts": [text]
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        final parsedJson = jsonDecode(json);
        final result = parsedJson["translations"][0]["text"].toString();
        _cache[text] = <String>[result];
        return <String>[result];
      }
      log(response.reasonPhrase.toString());
      return <String>[];
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      return <String>[];
    }
  }
}
