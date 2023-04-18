// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/utils/string_utils.dart';

class LocalTranscriptions {
  String fileToString = "";
  final Map<String, String> _cache = <String, String>{};

  Future<String> getTranscription(String content) async {
    content = content.trim().toLowerCase();

    if (_cache.containsKey(content)) {
      return _cache[content]!;
    }

    if (fileToString.isEmpty) {
      await load();
    }

    _cache[content] = content.contains(" ")
        ? "[${getParagraphs(content).map((e) => e.pieces.map((p) => p.isWord ? _getTranscriptionForWord(p.content)[0] : p.content).join()).join("\n")}]"
        : "[${_getTranscriptionForWord(content).join(" / ")}]";

    return _cache[content]!;
  }

  List<String> _getTranscriptionForWord(String word) {
    for (var line in fileToString.split("\n")) {
      final partsOfLine = line.split('\t');
      if (partsOfLine[0].toLowerCase() == word) {
        return partsOfLine[1].split(", ").toList();
      }
    }
    return [word];
  }

  Future load() async {
    fileToString = (await rootBundle
            .loadString('assets/transcriptions/words_transcriptions.txt'))
        .toLowerCase();
  }
}
