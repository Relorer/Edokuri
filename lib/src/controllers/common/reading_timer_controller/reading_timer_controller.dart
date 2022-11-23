import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/models/book.dart';

class ReadingTimerController {
  final DBController db;
  final Book book;

  DateTime? _startReading;

  ReadingTimerController(this.db, this.book);

  startReadingTimer() {
    _startReading = DateTime.now();
  }

  stopReadingTimer() {
    if (_startReading != null) {
      book.readTimes.add(ReadTime(_startReading!, DateTime.now()));
      db.putBook(book);
      _startReading = null;
    }
  }
}
