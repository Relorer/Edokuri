// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// 📦 Package imports:
import 'package:http/http.dart' as http;

const YandexTranslatorServiceKey = "YandexTranslatorServiceKey";

class YandexTranslatorService {
  final String _apiKey;

  YandexTranslatorService(this._apiKey);

  Future<String> translate(String text) async {
    if (_apiKey.isEmpty) {
      return "";
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
        return parsedJson["translations"][0]["text"];
      }
      log(response.reasonPhrase.toString());
      return "";
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      return "";
    }
  }
}
