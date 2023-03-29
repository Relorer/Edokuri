// 🐦 Flutter imports:

// 📦 Package imports:
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step1.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/step_serializer.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';
import 'package:edokuri/src/models/recordState/state_serializer.dart';

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
  late RecordStep step = RecordStep1.withRecord(this);

  @StateSerializer()
  RecordState state = RecordState.newborn;

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
    required this.step,
    this.state = RecordState.newborn,
    this.reviewNumber = 0,
    this.userId = "",
  }) {
    step.record = this;
  }

  factory Record.fromRecord(RecordModel record) =>
      Record.fromJson(record.toJson());

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}

bool timeForReviewHasCome(Record record) {
  return DateTime.now().millisecondsSinceEpoch -
          record.reviewInterval -
          record.lastReview.millisecondsSinceEpoch +
          lookIntoFutureMilliseconds >
      0;
}
