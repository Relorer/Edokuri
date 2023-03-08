import 'package:dictionaryx/dictentry.dart';
import 'package:dictionaryx/dictionary_msa_json_flutter.dart';
import 'package:freader/src/models/models.dart';

class MSAPartOfRecord {
  List<Meaning> meanings;
  List<String> synonyms;

  MSAPartOfRecord({
    required this.meanings,
    required this.synonyms,
  });
}

class MSADictionaryService {
  final _dMSA = DictionaryMSAFlutter();

  Future<MSAPartOfRecord> lookup(String word) async {
    List<Meaning> meanings = [];
    List<String> synonyms = [];

    if (await _dMSA.hasEntry(word)) {
      final wordInfo = await _dMSA.getEntry(word);

      synonyms.addAll(wordInfo.synonyms);

      for (var m in wordInfo.meanings) {
        meanings.add(
            Meaning(getFullName(m.pos), m.description, m.meanings, m.examples));
      }
    }

    return MSAPartOfRecord(meanings: meanings, synonyms: synonyms);
  }

  String getFullName(POS pos) {
    if (pos == POS.ADJ) return "Adjective";
    if (pos == POS.ADV) return "Adverb";
    if (pos == POS.NOUN) return "Noun";
    if (pos == POS.VERB) return "Verb";

    throw Exception("Index out of range");
  }
}
