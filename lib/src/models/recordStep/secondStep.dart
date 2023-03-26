// 🌎 Project imports:
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';
import 'package:edokuri/src/models/recordStep/firstStep.dart';
import 'package:edokuri/src/models/recordStep/foursStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';
import 'package:edokuri/src/models/recordStep/thirdStep.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

class SecondStep extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = oneMinute;
    record.lastReview = DateTime.now();
    record.recordStep = FirstStep();
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
    record.reviewInterval = oneDay;
    record.lastReview = DateTime.now();
    record.recordStep = ThirdStep();
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval = tenMinutes;
    record.lastReview = DateTime.now();
    record.recordStep = FirstStep();
  }
}
