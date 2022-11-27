import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/objectbox.g.dart' as box;
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'book_repository.g.dart';

class BookRepository = BookRepositoryBase with _$BookRepository;

abstract class BookRepositoryBase with Store {
  final box.Store store;
  final UserRepository userRepository;

  ObservableList<Book> books = ObservableList<Book>.of([]);

  BookRepositoryBase(this.store, this.userRepository) {
    getBooks(store).forEach(setNewList);
  }

  @action
  void setNewList(List<Book> newBooks) {
    books.clear();
    books.addAll(newBooks);
  }

  Stream<List<Book>> getBooks(box.Store store) {
    final query = store
        .box<Book>()
        .query(box.Book_.user.equals(userRepository.currentUser.id));
    return query
        .watch(triggerImmediately: true)
        .map<List<Book>>((query) => query.find());
  }

  void putBook(Book book) {
    book.user.target = userRepository.currentUser;
    store.box<Book>().put(book);
  }

  void removeBook(Book book) {
    store.box<Book>().remove(book.id);
  }

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
