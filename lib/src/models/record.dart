import 'package:freader/src/models/set.dart';
import 'package:freader/src/models/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Record {
  int id;
  final user = ToOne<User>();

  @Backlink("records")
  final sets = ToMany<SetRecords>();

  final translations = ToMany<Translation>();
  final meanings = ToMany<Meaning>();
  final examples = ToMany<Example>();
  final sentences = ToMany<Example>();
  final List<String> synonyms;
  final String original;
  @Unique()
  final String originalLowerCase;
  final String transcription;
  final DateTime creationDate;
  final DateTime lastReview;
  final int timeToNextReview;

  bool known;

  String get translation => translations
      .where((element) => element.selected)
      .map((element) => element.text)
      .join(", ");

  Record(
      {this.id = 0,
      required this.original,
      required this.originalLowerCase,
      required this.transcription,
      required this.synonyms,
      required this.known,
      required this.creationDate,
      required this.lastReview,
      required this.timeToNextReview});
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
