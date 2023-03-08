import 'package:freader/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'book_repository.g.dart';

class BookRepository = BookRepositoryBase with _$BookRepository;

abstract class BookRepositoryBase with Store {
  final PocketbaseController pb;
  final UserRepository userRepository;

  ObservableList<Book> books = ObservableList<Book>.of([]);

  BookRepositoryBase(this.pb, this.userRepository) {}

  @action
  void setNewList(List<Book> newBooks) {
    books.clear();
    books.addAll(newBooks);
  }

  Stream<List<Book>> getBooks() {
    return Stream.empty();
  }

  void putBook(Book book) {}

  void removeBook(Book book) {}

  int readingTimeForTodayInMinutes() {
    final today = DateTime.now();
    final readingTimesForToday = books
        .expand((element) => element.readTimes)
        .where((element) => element.start.isSameDate(today))
        .map((e) =>
            e.end.millisecondsSinceEpoch - e.start.millisecondsSinceEpoch);

    final readingTimeForToday = readingTimesForToday.isEmpty
        ? 0
        : readingTimesForToday.reduce((t1, t2) => t1 + t2);

    return readingTimeForToday / 1000 ~/ 60;
  }
}
