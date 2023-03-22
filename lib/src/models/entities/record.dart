// 🐦 Flutter imports:

// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/review_intervals.dart';
import 'package:edokuri/src/models/models.dart';

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

enum RecordState {
  recent,
  studied,
  repeatable,
}

class StepSerializer implements JsonConverter<RecordStep, String> {
  const StepSerializer();

  @override
  RecordStep fromJson(String step) {
    if (step == "firstStep") {
      return FirstStep();
    }
    if (step == "secondStep") {
      return SecondStep();
    }
    if (step == "thirdStep") {
      return ThirdStep();
    }
    return FoursStep();
  }

  @override
  String toJson(RecordStep step) {
    if (step is FirstStep) {
      return "firstStep";
    }
    if (step is SecondStep) {
      return "secondStep";
    }
    if (step is ThirdStep) {
      return "thirdStep";
    }
    return "foursStep";
  }
}

class StateSerializer implements JsonConverter<RecordState, String> {
  const StateSerializer();

  @override
  RecordState fromJson(String state) {
    if (state == RecordState.recent.toString().split('.').last) {
      return RecordState.recent;
    }
    if (state == RecordState.repeatable.toString().split('.').last) {
      return RecordState.repeatable;
    }
    return RecordState.studied;
  }

  @override
  String toJson(RecordState state) {
    if (state.toString() == RecordState.recent.toString().split('.').last) {
      return RecordState.recent.toString().split('.').last;
    }
    if (state.toString() == RecordState.repeatable.toString().split('.').last) {
      return RecordState.repeatable.toString().split('.').last;
    }
    return RecordState.studied.toString().split('.').last;
  }
}

abstract class RecordStep {
  void markWordEasy(Record record);
  void markWordGood(Record record);
  void markWordHard(Record record);
  void markWordAgain(Record record);
}

class FirstStep extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = getNextReviewTime(0);
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
  }

  @override
  void markWordEasy(Record record) {
    record.reviewInterval = getNextReviewTime(6);
    record.recordState = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.recordStep = FoursStep();
  }

  @override
  void markWordGood(Record record) {
    record.reviewInterval = getNextReviewTime(2);
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
    record.recordStep = SecondStep();
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval = getNextReviewTime(1);
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
  }
}

class SecondStep extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = getNextReviewTime(0);
    record.lastReview = DateTime.now();
    record.recordStep = FirstStep();
  }

  @override
  void markWordEasy(Record record) {
    record.reviewInterval = getNextReviewTime(6);
    record.recordState = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.recordStep = FoursStep();
  }

  @override
  void markWordGood(Record record) {
    record.reviewInterval = getNextReviewTime(3);
    record.lastReview = DateTime.now();
    record.recordStep = ThirdStep();
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval = getNextReviewTime(2);
    record.lastReview = DateTime.now();
    record.recordStep = FirstStep();
  }
}

class ThirdStep extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = getNextReviewTime(2);
    record.lastReview = DateTime.now();
    record.recordStep = FirstStep();
  }

  @override
  void markWordEasy(Record record) {
    record.reviewInterval = getNextReviewTime(6);
    record.recordState = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.recordStep = FoursStep();
  }

  @override
  void markWordGood(Record record) {
    record.reviewInterval = getNextReviewTime(5);
    record.recordState = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.recordStep = FoursStep();
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval = getNextReviewTime(4);
    record.lastReview = DateTime.now();
    record.recordStep = FirstStep();
  }
}

class FoursStep extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = getNextReviewTime(2);
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
    record.recordStep = FirstStep();
  }

  @override
  void markWordEasy(Record record) {
    record.reviewInterval = (record.reviewInterval *
        getIntervalMultiplier(2) *
        getIntervalMultiplier(1)) as int;
    record.reviewInterval = roundDays(record.reviewInterval);
    record.lastReview = DateTime.now();
  }

  @override
  void markWordGood(Record record) {
    record.reviewInterval =
        (record.reviewInterval * getIntervalMultiplier(2)) as int;
    record.reviewInterval = roundDays(record.reviewInterval);
    record.lastReview = DateTime.now();
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval =
        (record.reviewInterval * getIntervalMultiplier(0)) as int;
    record.reviewInterval = roundDays(record.reviewInterval);
    record.lastReview = DateTime.now();
  }

  int roundDays(int interval) {
    if (interval > 1 * 24 * 60 * 60 * 1000 &&
        interval < 365 * 24 * 60 * 60 * 1000) // 1day < interval < 1 year
    {
      return interval ~/ (1 * 24 * 60 * 60 * 1000) +
          (((interval % (1 * 24 * 60 * 60 * 1000)) > (12 * 60 * 60 * 1000))
              ? 24 * 60 * 60 * 1000
              : 0);
    }
    if (interval > 365 * 24 * 60 * 60 * 1000) // interval > 1 year
    {
      return 365 * 24 * 60 * 60 * 1000;
    }
    return interval;
  }
}
