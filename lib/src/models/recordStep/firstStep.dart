// 🌎 Project imports:
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';
import 'package:edokuri/src/models/recordStep/foursStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';
import 'package:edokuri/src/models/recordStep/secondStep.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

class FirstStep extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = oneMinute;
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
  }

  @override
  void markWordEasy(Record record) {
    record.reviewInterval = fourDays;
    record.recordState = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.recordStep = FoursStep();
  }

  @override
  void markWordGood(Record record) {
    record.reviewInterval = tenMinutes;
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
    record.recordStep = SecondStep();
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval = sixMinutes;
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
  }
}
