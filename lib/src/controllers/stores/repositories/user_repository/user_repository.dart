import 'package:freader/src/controllers/stores/appwrite/appwrite_controller.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'user_repository.g.dart';

class UserRepository = UserRepositoryBase with _$UserRepository;

abstract class UserRepositoryBase with Store {
  final AppwriteController appwrite;

  ObservableList<SetRecords> sets = ObservableList<SetRecords>.of([]);

  UserRepositoryBase(this.appwrite) {}

  // int learningTimeForTodayInMinutes() {
  //   final today = DateTime.now();
  //   final learningTimesForToday = currentUser.learnTimes
  //       .where((element) => element.start.isSameDate(today))
  //       .map((e) =>
  //           e.end.millisecondsSinceEpoch - e.start.millisecondsSinceEpoch);

  //   final learningTimeForToday = learningTimesForToday.isEmpty
  //       ? 0
  //       : learningTimesForToday.reduce((t1, t2) => t1 + t2);

  //   return learningTimeForToday / 1000 ~/ 60;
  // }

  // void addTimeMarkForToday() {
  //   DateTime date = DateTime.now();
  //   if (currentUser.streak.isEmpty ||
  //       !currentUser.streak.last.dateTime.isSameDate(date)) {
  //     currentUser.streak.add(TimeMark(dateTime: date));
  //     updateUserInfo();
  //   }
  // }

  // int getStreak() {
  //   if (currentUser.streak.isEmpty) return 0;

  //   DateTime date = DateTime.now();
  //   int result = currentUser.streak.last.dateTime.isSameDate(date) ? 1 : 0;

  //   for (var element in currentUser.streak.reversed.skip(1)) {
  //     if (element.dateTime.isSameDate(date)) {
  //       result++;
  //     } else {
  //       break;
  //     }
  //     date.subtract(const Duration(days: 1));
  //   }

  //   return result;
  // }
}
