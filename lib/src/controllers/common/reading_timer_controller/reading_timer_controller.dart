// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/models/models.dart';

class ReadingTimerController {
  final BookRepository bookRepository;
  final ActivityTimeRepository activityTimeRepository;
  final TimeMarkRepository timeMarkRepository;
  final Book book;

  DateTime? _startReading;

  ReadingTimerController(this.bookRepository, this.activityTimeRepository,
      this.timeMarkRepository, this.book);

  startReadingTimer() {
    _startReading = DateTime.now();
  }

  stopReadingTimer() async {
    if (_startReading != null) {
      final at = await activityTimeRepository.putActivityTime(
          ActivityTime(_startReading!, DateTime.now(), Type.reading));

      _startReading = null;

      if (at == null) return;

      book.readTimes.add(at.id);
      book.lastReading = DateTime.now();
      bookRepository.putBook(book);

      timeMarkRepository.addTimeMarkForToday();
    }
  }
}
