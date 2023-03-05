import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/models/activity_time.dart';

class LearningTimerController {
  final UserRepository userRepository;

  DateTime? _startReading;

  LearningTimerController(this.userRepository);

  startReadingTimer() {
    // _startReading = DateTime.now();
  }

  stopReadingTimer() {
    // if (_startReading != null) {
    //   userRepository.currentUser.learnTimes
    //       .add(ActivityTime(_startReading!, DateTime.now()));
    //   userRepository.updateUserInfo();
    //   _startReading = null;
    //   userRepository.addTimeMarkForToday();
    // }
  }
}
