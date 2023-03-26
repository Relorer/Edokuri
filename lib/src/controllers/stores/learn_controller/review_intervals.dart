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

bool timeForReviewHasCome(Record record) {
  return DateTime.now().millisecondsSinceEpoch -
          record.reviewInterval -
          record.lastReview.millisecondsSinceEpoch >
      0;
}
