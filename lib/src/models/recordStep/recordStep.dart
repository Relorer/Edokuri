// 🌎 Project imports:
import 'package:edokuri/src/models/entities/record.dart';

abstract class RecordStep {
  void markWordEasy(Record record);
  void markWordGood(Record record);
  void markWordHard(Record record);
  void markWordAgain(Record record);
}
