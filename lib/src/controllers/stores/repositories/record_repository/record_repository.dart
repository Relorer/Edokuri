// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:edokuri/src/models/models.dart';

part 'record_repository.g.dart';

class RecordRepository = RecordRepositoryBase with _$RecordRepository;

abstract class RecordRepositoryBase with Store {
  final PocketbaseController pb;
  final UserRepository userRepository;

  ObservableList<Record> records = ObservableList<Record>.of([]);

  RecordRepositoryBase(this.pb, this.userRepository);

  @action
  void setNewList(List<Record> newRecords) {
    records.clear();
    records.addAll(newRecords);
  }

  List<Record> getRecordsByBook(Book book) {
    return records
        .where((element) =>
            book.words.any((word) => word == element.original.toLowerCase()))
        .toList();
  }

  List<Record> getRecordsBySet(SetRecords set) {
    return records
        .where((element) => element.sets.any((element) => element.id == set.id))
        .toList();
  }

  List<Record> getSavedRecordsByBook(Book book) {
    return getRecordsByBook(book)
        .where((element) => book.words.any((word) => !element.known))
        .toList();
  }

  int newWordsInBook(Book book) {
    final wordsInBook = getRecordsByBook(book).toList();
    if (book.words.isEmpty || wordsInBook.isEmpty) return 100;
    return 100 - (wordsInBook.length / book.words.length * 100).toInt();
  }

  Record? getRecord(String original) {
    return null;
  }

  void putRecord(Record record, {SetRecords? set}) {}

  void removeRecord(Record record, {SetRecords? set}) {}
}
