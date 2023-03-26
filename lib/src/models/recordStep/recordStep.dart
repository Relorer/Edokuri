// 🌎 Project imports:
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';
import 'package:edokuri/src/models/recordStep/recordStep1.dart';
import 'package:edokuri/src/models/recordStep/recordStep4.dart';

abstract class RecordStep {
  void markWordEasy(Record record) {
    record.recordState = RecordState.repeatable;
    record.lastReview = DateTime.now();
    record.recordStep = RecordStep4();
  }

  void markWordGood(Record record) {
    record.lastReview = DateTime.now();
  }

  void markWordHard(Record record) {
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
    record.recordStep = RecordStep1();
  }

  void markWordAgain(Record record) {
    record.recordState = RecordState.studied;
    record.lastReview = DateTime.now();
    record.recordStep = RecordStep1();
  }
}
