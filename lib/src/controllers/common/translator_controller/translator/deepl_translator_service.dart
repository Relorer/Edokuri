// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

// 📦 Package imports:
import 'package:http/http.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/translator.dart';

// 🌎 Project imports:

class DeeplTranslator implements Translator {
  final Map<String, List<String>> _cache = {};

  late int id;

  DeeplTranslator() {
    id = getRandomNumber();
  }

  int getICount(String translateText) {
    return translateText.split("i").length - 1;
  }

  int getRandomNumber() {
    final random = Random();
    final num = random.nextInt(99999) + 8300000;
    return num * 1000;
  }

  int getTimeStamp(int iCount) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    if (iCount != 0) {
      iCount = iCount + 1;
      return ts - ts % iCount + iCount;
    } else {
      return ts;
    }
  }

  Future<List<String>> _translate(
      String translateText, sourceLang, targetLang) async {
    var url = "https://www2.deepl.com/jsonrpc";
    id += 1;

    var postData = initData(sourceLang, targetLang);
    var text = Text(text: translateText, requestAlternatives: 3);
    postData.id = id;
    postData.params.texts.add(text);
    postData.params.timestamp = getTimeStamp(getICount(translateText));
    var postByte = jsonEncode(postData);

    if ((id + 5) % 29 == 0 || (id + 3) % 13 == 0) {
      postByte = postByte.replaceAll("\"method\":\"", "\"method\" : \"");
    } else {
      postByte = postByte.replaceAll("\"method\":\"", "\"method\": \"");
    }

    var reader = ByteStream.fromBytes(utf8.encode(postByte));
    var request = Request("POST", Uri.parse(url));

    request.headers["Content-Type"] = "application/json";
    request.headers["Accept"] = "*/*";
    request.headers["x-app-os-name"] = "iOS";
    request.headers["x-app-os-version"] = "16.3.0";
    request.headers["Accept-Language"] = "en-US,en;q=0.9";
    request.headers["Accept-Encoding"] = "gzip, deflate, br";
    request.headers["x-app-device"] = "iPhone13,2";
    request.headers["User-Agent"] = "DeepL-iOS/2.6.0 iOS 16.3.0 (iPhone13,2)";
    request.headers["x-app-build"] = "353933";
    request.headers["x-app-version"] = "2.6";
    request.headers["Connection"] = "keep-alive";
    request.bodyBytes = await reader.toBytes();

    var client = Client();
    var resp = await client.send(request);
    var body = await resp.stream.bytesToString();
    var res = jsonDecode(body);

    if (resp.statusCode != HttpStatus.ok) {
      dev.log("Deepl status code: ${resp.statusCode}");
      return [];
    } else {
      List<String> translations = [];
      translations.add(res["result"]["texts"][0]["text"]);
      for (var alt in res["result"]["texts"][0]["alternatives"]) {
        translations.add(alt["text"]);
      }
      return translations;
    }
  }

  @override
  Future<List<String>> translate(String text, String from, String to) async {
    if (_cache.containsKey(text)) {
      return _cache[text]!;
    }
    final result = _translate(text, from, to);
    _cache[text] = await result;
    return result;
  }

  @override
  bool get needInternet => true;

  @override
  String get source => deeplSource;
}

class Lang {
  String sourceLangUserSelected;
  String targetLang;

  Lang({required this.sourceLangUserSelected, required this.targetLang});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source_lang_user_selected'] = sourceLangUserSelected;
    data['target_lang'] = targetLang;
    return data;
  }
}

class CommonJobParams {
  bool wasSpoken;
  String transcribeAS;

  CommonJobParams({required this.wasSpoken, required this.transcribeAS});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wasSpoken'] = wasSpoken;
    data['transcribe_as'] = transcribeAS;
    return data;
  }
}

class Params {
  List<Text> texts = <Text>[];
  String splitting;
  Lang lang;
  int timestamp;
  CommonJobParams commonJobParams;

  Params({
    required this.splitting,
    required this.lang,
    this.timestamp = 0,
    required this.commonJobParams,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['texts'] = texts.map((e) => e.toJson()).toList();
    data['splitting'] = splitting;
    data['lang'] = lang.toJson();
    data['timestamp'] = timestamp;
    data['commonJobParams'] = commonJobParams.toJson();
    return data;
  }
}

class Text {
  String text;
  int requestAlternatives;

  Text({required this.text, required this.requestAlternatives});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['requestAlternatives'] = requestAlternatives;
    return data;
  }
}

class PostData {
  String jsonrpc;
  String method;
  int id;
  Params params;

  PostData({
    required this.jsonrpc,
    required this.method,
    this.id = 0,
    required this.params,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonrpc'] = jsonrpc;
    data['method'] = method;
    data['id'] = id;
    data['params'] = params.toJson();
    return data;
  }
}

PostData initData(String sourceLang, String targetLang) {
  return PostData(
    jsonrpc: "2.0",
    method: "LMT_handle_texts",
    params: Params(
      splitting: "newlines",
      lang: Lang(
        sourceLangUserSelected: sourceLang,
        targetLang: targetLang,
      ),
      commonJobParams: CommonJobParams(
        wasSpoken: false,
        transcribeAS: "",
        // regionalVariant: "en-US",
      ),
    ),
  );
}
