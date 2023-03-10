import 'package:freader/src/controllers/stores/learn_controller/review_intervals.dart';
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
  @Unique(onConflict: ConflictStrategy.replace)
  final String originalLowerCase;
  final String transcription;
  final DateTime creationDate;

  DateTime lastReview;
  double interval;

  bool known;

  RecordState state = RecordState.recent;
  RecordStep step = FirstStep();

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
      required this.interval});
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

enum RecordState{
  recent,
  studied,
  repeatable,
}

abstract class RecordStep{
  void getEasy(Record record);
  void getGood(Record record);
  void getHard(Record record);
  void getAgain(Record record);
}

class FirstStep extends RecordStep{
  @override
  void getAgain(Record record) {
    record.interval = getNextReviewTime(0) as double;
    record.state = RecordState.studied;
    record.lastReview = DateTime.now();
  }

  @override
  void getEasy(Record record) {
    record.interval = getNextReviewTime(6) as double;
    record.state = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.step = FoursStep();
  }

  @override
  void getGood(Record record) {
    record.interval = getNextReviewTime(2) as double;
    record.state = RecordState.studied;
    record.lastReview = DateTime.now();
    record.step = SecondStep();
  }

  @override
  void getHard(Record record) {
    record.interval = getNextReviewTime(1) as double;
    record.state = RecordState.studied;
    record.lastReview = DateTime.now();
  }
}

class SecondStep extends RecordStep{
  @override
  void getAgain(Record record) {
    record.interval = getNextReviewTime(0) as double;
    record.lastReview = DateTime.now();
    record.step = FirstStep();
  }

  @override
  void getEasy(Record record) {
    record.interval = getNextReviewTime(6) as double;
    record.state = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.step = FoursStep();
  }

  @override
  void getGood(Record record) {
    record.interval = getNextReviewTime(3) as double;
    record.lastReview = DateTime.now();
    record.step = ThirdStep();
  }

  @override
  void getHard(Record record) {
    record.interval = getNextReviewTime(2) as double;
    record.lastReview = DateTime.now();
    record.step = FirstStep();
  }
}

class ThirdStep extends RecordStep{
  @override
  void getAgain(Record record) {
    record.interval = getNextReviewTime(2) as double;
    record.lastReview = DateTime.now();
    record.step = FirstStep();
  }

  @override
  void getEasy(Record record) {
    record.interval = getNextReviewTime(6) as double;
    record.state = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.step = FoursStep();
  }

  @override
  void getGood(Record record) {
    record.interval = getNextReviewTime(5) as double;
    record.state = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.step = FoursStep();
  }

  @override
  void getHard(Record record) {
    record.interval = getNextReviewTime(4) as double;
    record.lastReview = DateTime.now();
    record.step = FirstStep();
  }
}

class FoursStep extends RecordStep{
  @override
  void getAgain(Record record) {
    record.interval = getNextReviewTime(2) as double;
    record.state = RecordState.studied;
    record.lastReview = DateTime.now();
    record.step = FirstStep();
  }

  @override
  void getEasy(Record record) {
    record.interval = record.interval * getIntervalMultiplier(2) * getIntervalMultiplier(1);
    record.lastReview = DateTime.now();
  }

  @override
  void getGood(Record record) {
    record.interval = record.interval * getIntervalMultiplier(2);
    record.lastReview = DateTime.now();
  }

  @override
  void getHard(Record record) {
    record.interval = record.interval * getIntervalMultiplier(0);
    record.lastReview = DateTime.now();
  }

}
