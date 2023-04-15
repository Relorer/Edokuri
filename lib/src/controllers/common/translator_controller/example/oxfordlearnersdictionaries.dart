// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:random_x/random_x.dart';

class OxfordLearnersDictionary {
  final Map<String, List<String>> _cache = {};

  Future<List<String>> fetchExamples(String word) async {
    word = word.toLowerCase().trim();

    if (_cache.containsKey(word)) {
      return _cache[word]!;
    }

    _cache[word] = [];

    try {
      final url =
          'https://www.oxfordlearnersdictionaries.com/definition/english/${word}_1';
      _cache[word] = await tryGetExamples(url);
    } catch (e) {
      try {
        await Future.delayed(const Duration(seconds: 1));
        final url =
            'https://www.oxfordlearnersdictionaries.com/definition/english/$word';
        _cache[word] = await tryGetExamples(url);
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");
        return <String>[];
      }
    }

    return _cache[word]!;
  }

  Future<List<String>> tryGetExamples(String url) async {
    var request = Request("GET", Uri.parse(url));

    request.headers["Accept"] = "*/*";
    request.headers["Accept-Language"] = "en-US,en;q=0.9";
    request.headers["Accept-Encoding"] = "gzip, deflate, br";
    request.headers["User-Agent"] =
        RndX.getRandomUA(count: 1, type: UserAgentType.macOs);

    var client = Client();
    var resp = await client.send(request).timeout(const Duration(seconds: 30));
    var body = await resp.stream.bytesToString();

    if (resp.statusCode == 200) {
      final document = parse(body);
      final sentences =
          document.querySelectorAll('.x').map((e) => e.text).toList();
      return sentences;
    } else {
      return <String>[];
    }
  }
}
