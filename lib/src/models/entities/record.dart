// 🐦 Flutter imports:

// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';
import 'package:edokuri/src/models/recordState/stateSerializer.dart';
import 'package:edokuri/src/models/recordStep/firstStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';
import 'package:edokuri/src/models/recordStep/stepSerializer.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  String id;
  String userId;

  final List<Translation> translations;
  final List<Meaning> meanings;
  final List<Example> examples;
  final List<Example> sentences;
  final List<String> synonyms;
  final String original;
  final String originalLowerCase;
  final String transcription;
  final DateTime creationDate;
  DateTime lastReview;
  int reviewNumber;
  int reviewInterval = 0;

  @StepSerializer()
  RecordStep recordStep = FirstStep();
  @StateSerializer()
  RecordState recordState = RecordState.recent;

  String get translation => translations
      .where((element) => element.selected)
      .map((element) => element.text)
      .join(", ");

  Record({
    this.id = "",
    required this.original,
    required this.originalLowerCase,
    required this.transcription,
    required this.creationDate,
    required this.examples,
    required this.meanings,
    required this.synonyms,
    required this.sentences,
    required this.translations,
    required this.lastReview,
    required this.recordStep,
    this.recordState = RecordState.recent,
    this.reviewNumber = 0,
    this.userId = "",
  });

  void markWordEasy() {
    recordStep.markWordEasy(this);
    reviewNumber++;
  }

  void markWordGood() {
    recordStep.markWordGood(this);
    reviewNumber++;
  }

  void markWordHard() {
    recordStep.markWordHard(this);
    reviewNumber++;
  }

  void markWordAgain() {
    recordStep.markWordAgain(this);
    reviewNumber++;
  }

  static int compareTo(Record a, Record b) {
    return a.reviewInterval - b.reviewInterval;
  }

  factory Record.fromRecord(RecordModel record) =>
      Record.fromJson(record.toJson());

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}

bool timeForReviewHasCome(Record record) {
  return DateTime.now().millisecondsSinceEpoch -
          record.reviewInterval -
          record.lastReview.millisecondsSinceEpoch >
      0;
}
