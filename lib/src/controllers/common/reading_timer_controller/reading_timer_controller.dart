// Project imports:
import 'package:edokuri/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:edokuri/src/models/models.dart';

class ReadingTimerController {
  final BookRepository bookRepository;
  final UserRepository userRepository;
  final Book book;

  DateTime? _startReading;

  ReadingTimerController(this.bookRepository, this.userRepository, this.book);

  startReadingTimer() {
    _startReading = DateTime.now();
  }

  stopReadingTimer() {
    if (_startReading != null) {
      book.readTimes.add(ActivityTime(_startReading!, DateTime.now()));
      bookRepository.putBook(book);
      _startReading = null;
      userRepository.addTimeMarkForToday();
    }
  }
}
