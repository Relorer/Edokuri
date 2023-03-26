// 🌎 Project imports:
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep3.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

class RecordStep2 extends RecordStep {
  @override
  void markWordAgain(Record record) {
    record.reviewInterval = oneMinute;
    super.markWordAgain(record);
  }

  @override
  void markWordEasy(Record record) {
    record.reviewInterval = fourDays;
    super.markWordEasy(record);
  }

  @override
  void markWordGood(Record record) {
    record.reviewInterval = oneDay;
    record.recordStep = RecordStep3();
    super.markWordGood(record);
  }

  @override
  void markWordHard(Record record) {
    record.reviewInterval = tenMinutes;
    super.markWordHard(record);
  }
}
