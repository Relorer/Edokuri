// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/review_intervals.dart';
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';
import 'package:edokuri/src/models/recordStep/firstStep.dart';
import 'package:edokuri/src/models/recordStep/foursStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';

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
