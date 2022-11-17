import 'package:freader/src/models/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Record {
  int id;
  final user = ToOne<User>();

  final translations = ToMany<Translation>();
  final meanings = ToMany<Meaning>();
  final examples = ToMany<Example>();
  final List<String> synonyms;
  final String original;
  final String sentence;
  final DateTime creationDate;

  bool known;

  Record(
      {this.id = 0,
      required this.original,
      required this.synonyms,
      required this.sentence,
      required this.known,
      required this.creationDate});
}

@Entity()
class Translation {
  int id;

  final String text;
  final String source;
  bool selected;
  DateTime? selectionDate;

  Translation(this.text,
      {this.id = 0,
      this.selected = false,
      required this.source,
      this.selectionDate});
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
