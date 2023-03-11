// 📦 Package imports:
import 'dart:developer';

import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:edokuri/src/models/models.dart';

part 'record_repository.g.dart';

class RecordRepository = RecordRepositoryBase with _$RecordRepository;

const _record = "record";

abstract class RecordRepositoryBase with Store {
  final PocketbaseController pb;
  final UserRepository userRepository;

  ObservableList<Record> records = ObservableList<Record>.of([]);

  RecordRepositoryBase(this.pb, this.userRepository) {
    pb.client.collection(_record).getFullList().then(
        (value) => records.addAll(value.map((e) => Record.fromRecord(e))));
    pb.client.collection(_record).subscribe("*", (e) {
      try {
        if (e.record == null) return;
        final record = Record.fromRecord(e.record!);
        records.removeWhere((element) => element.id == record.id);
        if (e.action == "update" || e.action == "create") {
          records.add(record);
        }
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");
      }
    });
  }

  List<Record> getRecordsByBook(Book book) {
    return records
        .where((element) =>
            book.words.any((word) => word == element.original.toLowerCase()))
        .toList();
  }

  List<Record> getRecordsBySet(SetRecords set) {
    //TODO
    // return records
    //     .where((element) => element.setIds.any((id) => id == set.id))
    //     .toList();
    return [];
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
    final fromCache = records.where((element) =>
        element.originalLowerCase == original.toLowerCase().trim());

    if (fromCache.isNotEmpty) {
      return fromCache.first;
    }
    return null;
  }

  void putRecord(Record record, {SetRecords? set}) async {
    try {
      record.id = records
          .firstWhere(
              (element) =>
                  element.originalLowerCase == record.originalLowerCase,
              orElse: () => record)
          .id;
      final body = record.toJson()..["user"] = pb.user?.id;
      if (record.id.isEmpty) {
        await pb.client.collection(_record).create(body: body);
      } else {
        await pb.client.collection(_record).update(record.id, body: body);
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  void removeRecord(Record record, {SetRecords? set}) async {
    //TODO
    try {
      await pb.client.collection(_record).delete(record.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
