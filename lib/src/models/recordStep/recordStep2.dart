// 🌎 Project imports:
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep1.dart';
import 'package:edokuri/src/models/recordStep/recordStep3.dart';
import 'package:edokuri/src/models/recordStep/recordStep4.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

class RecordStep2 extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = oneMinute;
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
    record.recordStep = RecordStep1();
    record.reviewNumber++;
  }

  @override
  void markWordEasy(Record record) {
    record.reviewInterval = fourDays;
    record.recordState = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.recordStep = RecordStep4();
    record.reviewNumber++;
  }

  @override
  void markWordGood(Record record) {
    record.reviewInterval = oneDay;
    record.recordStep = RecordStep3();
    record.lastReview = DateTime.now();
    record.reviewNumber++;
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval = tenMinutes;
    record.recordStep = RecordStep1();
    record.lastReview = DateTime.now();
    record.reviewNumber++;
  }
}
