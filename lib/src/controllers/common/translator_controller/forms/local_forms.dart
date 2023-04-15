// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/utils/string_utils.dart';

class LocalForms {
  String words = "";

  Future<List<String>> getForms(String word) async {
    word = word.toLowerCase();
    if (words.isEmpty) {
      await load();
    }
    for (var line in words.split("\n")) {
      if (line.contains(word)) {
        if (isWholeWordInString(word, line)) {
          return line.split('\t')..remove(word);
        }
      }
    }
    return [];
  }

  Future load() async {
    words = await rootBundle.loadString('assets/words/word_forms.txt');
  }
}
