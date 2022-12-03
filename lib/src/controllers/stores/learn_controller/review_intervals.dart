import 'package:freader/src/models/models.dart';

int getNextReviewTime(int reviewNumber) {
  switch (reviewNumber) {
    case 0:
      return 20 * 60 * 1000; // 20 min
    case 1:
      return 1 * 60 * 60 * 1000; // 1 h
    case 2:
      return 9 * 60 * 60 * 1000; // 9 h
    case 3:
      return 1 * 24 * 60 * 60 * 1000; // 1 d
    case 4:
      return 2 * 24 * 60 * 60 * 1000; // 2 d
    case 5:
      return 6 * 24 * 60 * 60 * 1000; // 6 d
    case 6:
      return 31 * 24 * 60 * 60 * 1000; // 31 d
    default:
      return reviewNumber * getNextReviewTime(6);
  }
}

bool timeForReviewHasCome(Record record) {
  return DateTime.now().millisecondsSinceEpoch -
          getNextReviewTime(record.reviewNumber) -
          record.lastReview.millisecondsSinceEpoch >
      0;
}
