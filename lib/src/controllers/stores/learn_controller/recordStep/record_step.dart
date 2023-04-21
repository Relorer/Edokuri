// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/date_controller/date_controller.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

abstract class RecordStep {
  late Record record;

  RecordStep();

  RecordStep.withRecord(this.record);

  RecordState get easyNextState;
  RecordState get goodNextState;
  RecordState get hardNextState;
  RecordState get againNextState;

  int get easyNextInterval;
  int get goodNextInterval;
  int get hardNextInterval;
  int get againNextInterval;

  RecordStep get easyNextStep;
  RecordStep get goodNextStep;
  RecordStep get hardNextStep;
  RecordStep get againNextStep;

  String get easyNextIntervalText => _formatMilliseconds(easyNextInterval);
  String get goodNextIntervalText => _formatMilliseconds(goodNextInterval);
  String get hardNextIntervalText => _formatMilliseconds(hardNextInterval);
  String get againNextIntervalText => _formatMilliseconds(againNextInterval);

  void markWordEasy(Record record) {
    record.reviewInterval = roundDays(easyNextInterval);
    record.state = easyNextState;
    record.step = easyNextStep;
    markWord(record);
  }

  void markWordGood(Record record) {
    record.reviewInterval = roundDays(goodNextInterval);
    record.state = goodNextState;
    record.step = goodNextStep;
    markWord(record);
  }

  void markWordHard(Record record) {
    record.reviewInterval = roundDays(hardNextInterval);
    record.state = hardNextState;
    record.step = hardNextStep;
    markWord(record);
  }

  void markWordAgain(Record record) {
    record.reviewInterval = roundDays(againNextInterval);
    record.state = againNextState;
    record.step = againNextStep;
    markWord(record);
  }

  void markWord(Record record) {
    record.lastReview = getIt<DateController>().now();
    record.reviewNumber++;
  }

  int roundDays(int interval) {
    if (interval > oneDay) {
      return (interval ~/ (oneDay) +
              (((interval % (oneDay)) > (oneDay / 2)) ? 1 : 0)) *
          oneDay;
    }
    return interval;
  }

  String _formatMilliseconds(int milliseconds) {
    const int minuteInMs = 60 * 1000;
    const int hourInMs = 60 * minuteInMs;
    const int dayInMs = 24 * hourInMs;

    int days = milliseconds ~/ dayInMs;
    int hours = (milliseconds % dayInMs) ~/ hourInMs;
    int minutes = (milliseconds % hourInMs) ~/ minuteInMs;

    if (days > 0) {
      return "${days}d ";
    } else if (hours > 0) {
      return "${hours}h ";
    } else {
      if (minutes <= lookIntoFuture) {
        return "< ${minutes}m";
      }
      return "${minutes}m";
    }
  }
}
