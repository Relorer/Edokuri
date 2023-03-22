// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';

int getNextReviewTime(int reviewNumber) {
  switch (reviewNumber) {
    case 0:
      return 60 * 1000; // 1 min
    case 1:
      return 6 * 60 * 1000; // 6 min
    case 2:
      return 10 * 60 * 1000; // 10 min
    case 3:
      return 1 * 24 * 60 * 60 * 1000; // 1 d
    case 4:
      return 2 * 24 * 60 * 60 * 1000; // 2 d
    case 5:
      return 3 * 24 * 60 * 60 * 1000; // 3 d
    case 6:
      return 4 * 24 * 60 * 60 * 1000; // 4 d
    default:
      return reviewNumber;
  }
}

double getIntervalMultiplier(int multiplierNumber) {
  switch (multiplierNumber) {
    case 0:
      return 1.2;
    case 1:
      return 1.3;
    case 2:
      return 2.5;
    default:
      return multiplierNumber as double;
  }
}

bool timeForReviewHasCome(Record record) {
  return DateTime.now().millisecondsSinceEpoch -
          record.reviewInterval -
          record.lastReview.millisecondsSinceEpoch >
      -20 * 60 * 1000; // 20 min
}
