import 'dart:convert';

class Record {
  String id;
  final List<Translation> translations;
  final List<Meaning> meanings;
  final List<Example> examples;
  final List<Example> sentences;
  final List<String> synonyms;
  final String original;
  final String originalLowerCase;
  final String transcription;
  final DateTime creationDate;

  bool known;

  String get translation => translations
      .where((element) => element.selected)
      .map((element) => element.text)
      .join(", ");

  Record(
      {required this.original,
      required this.originalLowerCase,
      required this.transcription,
      required this.synonyms,
      required this.known,
      required this.creationDate,
      this.examples = const [],
      this.meanings = const [],
      this.sentences = const [],
      this.translations = const [],
      this.id = ""});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'translations': json.encode(translations),
      'meanings': json.encode(meanings),
      'examples': json.encode(examples),
      'sentences': json.encode(sentences),
      'synonyms': synonyms,
      'original': original,
      'originalLowerCase': originalLowerCase,
      'transcription': transcription,
      'creationDate': creationDate,
      'known': known,
    };
  }

  static Record fromJson(Map<String, dynamic> jsonMap) {
    return Record(
      id: jsonMap['id'] as String,
      original: jsonMap['original'] as String,
      originalLowerCase: jsonMap['originalLowerCase'] as String,
      transcription: jsonMap['transcription'] as String,
      synonyms: jsonMap['synonyms'] as List<String>,
      known: jsonMap['known'] as bool,
      creationDate: jsonMap['creationDate'] as DateTime,
      examples: json.decode(jsonMap['examples'] as String),
      meanings: json.decode(jsonMap['meanings'] as String),
      sentences: json.decode(jsonMap['sentences'] as String),
      translations: json.decode(jsonMap['translations'] as String),
    );
  }
}

class Translation {
  final String text;
  final String source;
  bool selected;
  DateTime? selectionDate;

  Translation(this.text,
      {this.selected = false, required this.source, this.selectionDate});
}

class Example {
  final String text;
  final String tr;

  Example(this.text, this.tr);
}

class Meaning {
  String pos;

  String description;

  List<String> meanings;

  bool hasMeanings() => meanings.isNotEmpty;

  List<String> examples;

  bool hasExamples() => examples.isNotEmpty;

  Meaning(
    this.pos,
    this.description,
    this.meanings,
    this.examples,
  );
}
