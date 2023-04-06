// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:edokuri/src/core/service_locator.dart';

const YandexTranslatorServiceKey = "YandexTranslatorServiceKey";

class YandexTranslatorService {
  final Map<String, String> _cache = {};
  String _apiKey;

  YandexTranslatorService(this._apiKey);

  Future<String> translate(String text) async {
    if (_apiKey.isEmpty) {
      final secureStorage = getIt<FlutterSecureStorage>();
      _apiKey = await secureStorage.read(key: YandexTranslatorServiceKey) ?? "";
      if (_apiKey.isEmpty) {
        return "";
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
        "target_language_code": "ru",
        "source_language_code": "en",
        "texts": [text]
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        final parsedJson = jsonDecode(json);
        final result = parsedJson["translations"][0]["text"];
        _cache[text] = result;
        return result;
      }
      log(response.reasonPhrase.toString());
      return "";
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      return "";
    }
  }
}
