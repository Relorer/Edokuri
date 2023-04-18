import 'package:edokuri/src/core/utils/string_utils.dart';
import 'package:flutter/services.dart';

class LocalTranscriptions {
  Map<String, List<String>> wordsTranscriptions = {};
  String fileToString = "";

  Future<List<String>> getTranscriptions(String word) async {
    word = word.toLowerCase();
    if (fileToString.isEmpty) {
      await load();
    }
    for (var line in fileToString.split("\n")) {
      if (line.startsWith(word)) {
        return line.split('\t')[1].split(', ');
      }
    }
    return [];
  }

  Future load() async {
    fileToString = (await rootBundle.loadString('assets/transcriptions/words_transcriptions.txt')).toLowerCase();
  }
}