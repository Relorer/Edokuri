// 📦 Package imports:
import 'package:translator/translator.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/translator.dart';

class Google2Translator implements Translator {
  final _translator = GoogleTranslator();

  @override
  bool get needInternet => true;

  @override
  Future<List<String>> translate(String word, String from, String to) async {
    return <String>[
      (await _translator.translate(word, from: from, to: to)).text
    ];
  }

  @override
  String get source => googleSource;
}
