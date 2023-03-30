// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/models/models.dart';

class ReadingTimerController {
  final BookRepository bookRepository;
  final ActivityTimeRepository activityTimeRepository;
  final TimeMarkRepository timeMarkRepository;
  Book? book;

  DateTime? _startReading;

  ReadingTimerController(this.bookRepository, this.activityTimeRepository,
      this.timeMarkRepository);

  startReadingTimer(Book book) {
    _startReading = DateTime.now().toUtc();
    this.book = book;
  }

  stopReadingTimer() async {
    if (_startReading != null && book != null) {
      final start = _startReading!;
      _startReading = null;
      final at = await activityTimeRepository.putActivityTime(
          ActivityTime(start, DateTime.now().toUtc(), Type.reading));

      if (at == null) return;

      book!.readTimes.add(at.id);
      book!.lastReading = DateTime.now().toUtc();
      bookRepository.putBook(book!);

      timeMarkRepository.addTimeMarkForToday();
      book = null;
    }
  }
}
