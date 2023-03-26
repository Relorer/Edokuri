// 🌎 Project imports:
import 'package:edokuri/src/models/entities/record.dart';

void markWordEasy(Record record) {
  record.recordStep.markWordEasy(record);
  record.reviewNumber++;
}

void markWordGood(Record record) {
  record.recordStep.markWordGood(record);
  record.reviewNumber++;
}

void markWordHard(Record record) {
  record.recordStep.markWordHard(record);
  record.reviewNumber++;
}

void markWordAgain(Record record) {
  record.recordStep.markWordAgain(record);
  record.reviewNumber++;
}
