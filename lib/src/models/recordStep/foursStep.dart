// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/review_intervals.dart';
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';
import 'package:edokuri/src/models/recordStep/firstStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';

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
