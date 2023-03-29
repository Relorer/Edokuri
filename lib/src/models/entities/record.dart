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
  int reviewInterval;

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
    this.reviewInterval = 0,
    this.userId = "",
  }) {
    step.record = this;
  }

  factory Record.fromRecord(RecordModel record) =>
      Record.fromJson(record.toJson());

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);

  Record copyWith({
    String? id,
    String? userId,
    List<Translation>? translations,
    List<Meaning>? meanings,
    List<Example>? examples,
    List<Example>? sentences,
    List<String>? synonyms,
    String? original,
    String? originalLowerCase,
    String? transcription,
    DateTime? creationDate,
    DateTime? lastReview,
    int? reviewNumber,
    int? reviewInterval,
    RecordStep? step,
    RecordState? state,
  }) {
    return Record(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      translations: translations ?? this.translations,
      meanings: meanings ?? this.meanings,
      examples: examples ?? this.examples,
      sentences: sentences ?? this.sentences,
      synonyms: synonyms ?? this.synonyms,
      original: original ?? this.original,
      originalLowerCase: originalLowerCase ?? this.originalLowerCase,
      transcription: transcription ?? this.transcription,
      creationDate: creationDate ?? this.creationDate,
      lastReview: lastReview ?? this.lastReview,
      reviewNumber: reviewNumber ?? this.reviewNumber,
      reviewInterval: reviewInterval ?? this.reviewInterval,
      step: step ?? this.step,
      state: state ?? this.state,
    );
  }
}

bool timeForReviewHasCome(Record record) {
  return DateTime.now().toUtc().isAfter(DateTime.fromMillisecondsSinceEpoch(
      record.reviewInterval +
          record.lastReview.millisecondsSinceEpoch +
          lookIntoFutureMilliseconds));
}
