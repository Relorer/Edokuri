import 'package:freader/src/models/book.dart';
import 'package:mobx/mobx.dart';

import '../../../objectbox.g.dart' as box;
part 'db_controller.g.dart';

class DBController = DBControllerBase with _$DBController;

abstract class DBControllerBase with Store {
  ObservableList<Book> books = ObservableList<Book>.of([]);

  late box.Box<Book> _bookBox;

  DBControllerBase(box.Store store) {
    _bookBox = store.box<Book>();
    books.clear();
    books.addAll(_bookBox.query().build().find());
  }

  @action
  void putBook(Book book) {
    _bookBox.put(book);
    if (!books.contains(book)) {
      books.add(book);
    }
  }

  @action
  void removeBook(Book book) {
    _bookBox.remove(book.id);
    books.removeWhere((b) => b.id == book.id);
  }
}
