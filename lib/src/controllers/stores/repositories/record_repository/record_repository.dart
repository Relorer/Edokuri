import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/objectbox.g.dart' as box;
import 'package:mobx/mobx.dart';

part 'record_repository.g.dart';

class RecordRepository = RecordRepositoryBase with _$RecordRepository;

abstract class RecordRepositoryBase with Store {
  final box.Store store;
  final UserRepository userRepository;

  ObservableList<Record> records = ObservableList<Record>.of([]);

  RecordRepositoryBase(this.store, this.userRepository) {
    _getRecords(store).forEach(setNewList);
  }

  @action
  void setNewList(List<Record> newRecords) {
    records.clear();
    records.addAll(newRecords);
  }

  Stream<List<Record>> _getRecords(box.Store store) {
    final query = store
        .box<Record>()
        .query(box.Record_.user.equals(userRepository.currentUser.id));
    return query
        .watch(triggerImmediately: true)
        .map<List<Record>>((query) => query.find());
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
    return 100 - (wordsInBook.length / book.words.length * 100).toInt();
  }

  Record? getRecord(String original) {
    final fromCache = records.where((element) =>
        element.originalLowerCase == original.toLowerCase().trim());

    if (fromCache.isNotEmpty) {
      return fromCache.first;
    }
    return null;
  }

  void putRecord(Record record, {SetRecords? set}) {
    if (set != null) {
      record.sets.add(set);
    }

    record.user.target = userRepository.currentUser;
    store.box<Record>().put(record);
    store.box<Translation>().putMany(record.translations);
    store.box<Meaning>().putMany(record.meanings);
    store.box<Example>().putMany(record.examples);
    store.box<Example>().putMany(record.sentences);
    store.box<SetRecords>().putMany(record.sets);
  }

  void removeRecord(Record record, {SetRecords? set}) {
    if (set != null) {
      record.sets.removeWhere((element) => element.id == set.id);
      store.box<Record>().put(record);
      store.box<SetRecords>().put(set);
    } else {
      store.box<Record>().remove(record.id);
    }
  }
}
