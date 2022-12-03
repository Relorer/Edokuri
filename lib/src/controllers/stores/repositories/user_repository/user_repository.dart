import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/objectbox.g.dart' as box;
import 'package:mobx/mobx.dart';

part 'user_repository.g.dart';

class UserRepository = UserRepositoryBase with _$UserRepository;

abstract class UserRepositoryBase with Store {
  final box.Store store;
  late User currentUser;

  UserRepositoryBase(this.store) {
    final userBox = store.box<User>();

    final temp = userBox.getAll();
    if (temp.isEmpty) {
      currentUser = User();
      currentUser.id = userBox.put(currentUser);
    } else {
      currentUser = temp.first;
    }
  }

  void updateUserInfo() {
    store.box<User>().put(currentUser);
  }

  int learningTimeForTodayInMinutes() {
    final today = DateTime.now();
    final learningTimesForToday = currentUser.learnTimes
        .where((element) => element.start.isSameDate(today))
        .map((e) =>
            e.end.millisecondsSinceEpoch - e.start.millisecondsSinceEpoch);

    final learningTimeForToday = learningTimesForToday.isEmpty
        ? 0
        : learningTimesForToday.reduce((t1, t2) => t1 + t2);

    return learningTimeForToday / 1000 ~/ 60;
  }
}
