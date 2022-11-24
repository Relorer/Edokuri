import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/set.dart';
import 'package:freader/src/models/user.dart';
import 'package:mobx/mobx.dart';

import '../../../../objectbox.g.dart' as box;
part 'db_controller.g.dart';

class DBController = DBControllerBase with _$DBController;

abstract class DBControllerBase with Store {
  late User _user;

  ObservableList<Book> books = ObservableList<Book>.of([]);
  ObservableList<Record> records = ObservableList<Record>.of([]);
  ObservableList<SetRecords> sets = ObservableList<SetRecords>.of([]);

  late box.Box<Book> _bookBox;
  late box.Box<User> _userBox;
  late box.Box<Record> _recordBox;
  late box.Box<SetRecords> _setBox;

  @computed
  int get readingTimeForTodayInMinutes {
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

  DBControllerBase(box.Store store) {
    _bookBox = store.box<Book>();
    _userBox = store.box<User>();
    _recordBox = store.box<Record>();
    _setBox = store.box<SetRecords>();
    books.addAll(_bookBox.query().build().find());
    sets.addAll(_setBox.query().build().find());

    final temp = _userBox.getAll();
    if (temp.isEmpty) {
      _user = User();
      _user.id = _userBox.put(_user);
    } else {
      _user = temp.first;
    }

    records.addAll(_user.records);
  }

  Record? getRecord(String original) {
    final fromCache = records.where((element) =>
        element.original.toLowerCase() == original.trim().toLowerCase());

    if (fromCache.isNotEmpty) {
      return fromCache.first;
    }
    return null;
  }

  @action
  void putBook(Book book) {
    book.id = _bookBox.put(book);
    if (books.contains(book)) {
      books.remove(book);
    }
    books.add(book);
  }

  @action
  void removeBook(Book book) {
    _bookBox.remove(book.id);
    books.removeWhere((b) => b.id == book.id);
  }

  List<Record> getRecordsByBook(Book book) {
    return records
        .where((element) =>
            book.words.any((word) => word == element.original.toLowerCase()))
        .toList();
  }

  List<Record> getSavedRecordsByBook(Book book) {
    return getRecordsByBook(book).where((element) => !element.known).toList();
  }

  @action
  void putRecord(Record record) {
    _recordBox.removeMany(records
        .where((element) =>
            element.original.toLowerCase() == record.original.toLowerCase())
        .map((e) => e.id)
        .toList());
    records.removeWhere((element) =>
        element.original.toLowerCase() == record.original.toLowerCase());

    record.user.target = _user;
    record.id = _recordBox.put(record);
    records.add(record);
  }

  @action
  void removeRecord(Record record) {
    _recordBox.remove(record.id);
    records.removeWhere((b) => b.id == record.id);
  }

  @action
  void putSet(SetRecords set) {
    set.id = _setBox.put(set);
    if (sets.contains(set)) {
      sets.remove(set);
    }
    sets.add(set);
  }

  @action
  void removeSet(SetRecords set) {
    _setBox.remove(set.id);
    sets.removeWhere((b) => b.id == set.id);
  }
}
