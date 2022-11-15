import 'package:objectbox/objectbox.dart';

@Entity()
class Record {
  int id;

  String original;
  final translations = ToMany<Translation>();
  final meanings = ToMany<Meaning>();
  final examples = ToMany<Example>();
  List<String> synonyms;

  String sentence;

  Record({
    this.id = 0,
    required this.original,
    required this.synonyms,
    required this.sentence,
  });
}

@Entity()
class Translation {
  int id;

  final String text;
  bool selected;
  final bool fromUser;

  Translation(this.text,
      {this.id = 0, this.selected = false, this.fromUser = false});
}

@Entity()
class Example {
  int id;

  final String text;
  final String tr;

  Example(this.text, this.tr, {this.id = 0});
}

@Entity()
class Meaning {
  int id;
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
    this.examples, {
    this.id = 0,
  });
}
