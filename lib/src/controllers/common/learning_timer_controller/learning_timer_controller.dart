// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/models/models.dart';

class LearningTimerController {
  final ActivityTimeRepository activityTimeRepository;
  final TimeMarkRepository timeMarkRepository;

  DateTime? _startLearning;

  LearningTimerController(this.activityTimeRepository, this.timeMarkRepository);

  startLearningTimer() {
    _startLearning = DateTime.now();
  }

  stopLearningTimer() async {
    if (_startLearning != null) {
      final at = await activityTimeRepository.putActivityTime(
          ActivityTime(_startLearning!, DateTime.now(), Type.learning));

      _startLearning = null;

      if (at == null) return;

      timeMarkRepository.addTimeMarkForToday();
    }
  }
}
