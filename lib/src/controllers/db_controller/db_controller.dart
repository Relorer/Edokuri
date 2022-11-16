import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/user.dart';
import 'package:mobx/mobx.dart';

import '../../../objectbox.g.dart' as box;
part 'db_controller.g.dart';

class DBController = DBControllerBase with _$DBController;

abstract class DBControllerBase with Store {
  late User _user;

  ObservableList<Book> books = ObservableList<Book>.of([]);
  ObservableList<Record> records = ObservableList<Record>.of([]);

  late box.Box<Book> _bookBox;
  late box.Box<User> _userBox;
  late box.Box<Record> _recordBox;

  DBControllerBase(box.Store store) {
    _bookBox = store.box<Book>();
    _userBox = store.box<User>();
    _recordBox = store.box<Record>();
    books.addAll(_bookBox.query().build().find());

    final temp = _userBox.getAll();

    if (temp.isEmpty) {
      _user = User();
      _userBox.put(_user);
    } else {
      _user = temp.first;
    }

    records.addAll(_user.records);
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

  @action
  void putRecord(Record record) {
    record.user.target = _user;
    _recordBox.put(record);
    if (!records.contains(record)) {
      records.add(record);
    }
  }

  @action
  void removeRecord(Record record) {
    _recordBox.remove(record.id);
    books.removeWhere((b) => b.id == record.id);
  }
}
