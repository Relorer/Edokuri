// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step1.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';

part 'record_repository.g.dart';

class RecordRepository = RecordRepositoryBase with _$RecordRepository;

const _record = "record";

abstract class RecordRepositoryBase with Store {
  final PocketbaseController pb;
  final SetRecordsRepository setRecordsRepository;
  final KnownRecordsRepository knownRecordsRepository;
  final TranslatorController translatorController =
      getIt<TranslatorController>();

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Record> records = ObservableList<Record>.of([]);

  RecordRepositoryBase(
      this.pb, this.setRecordsRepository, this.knownRecordsRepository) {
    isLoading = true;
    pb.client.collection(_record).getFullList().then((value) {
      records.addAll(value.map((e) => Record.fromRecord(e)));
      isLoading = false;

      ClearCache();
      pb.client.collection(_record).subscribe("*", (e) {
        try {
          ClearCache();
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
    });
  }

  void ClearCache() {
    _cache.clear();
    _newWordsInBookCache.clear();
  }

  void dispose() async {
    try {
      await pb.client.collection(_record).unsubscribe("*");
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  bool cached(Book book) =>
      _cache.containsKey(book) && _newWordsInBookCache.containsKey(book);

  Future<Record> updateTranslation(Record record) async {
    final newSentences = <Example>[];
    for (var sentence in record.sentences) {
      final translate =
          await translatorController.translateSentence(sentence.text);
      newSentences
          .add(Example(sentence.text, translate.text.first, translate.source));
    }
    record.sentences.clear();
    record.sentences.addAll(newSentences);

    final newExamples = <Example>[];
    for (var example in record.examples) {
      final translate =
          await translatorController.translateSentence(example.text);
      newExamples
          .add(Example(example.text, translate.text.first, translate.source));
    }
    record.examples.clear();
    record.examples.addAll(newExamples);

    return record;
  }

  Future updateTranslationWithSave(Record record) async {
    final newRecord = await updateTranslation(record);
    putRecord(newRecord);
  }

  Future updateTranslationWithSaveAll() async {
    final newRecords = <Record>[];
    for (var record in records) {
      newRecords.add(await updateTranslation(record));
      await Future.delayed(const Duration(seconds: 2));
    }

    for (var record in newRecords) {
      await putRecord(record);
    }
  }

  final Map<Book, List<Record>> _cache = {};

  List<Record> getSavedRecordsByBook(Book book) {
    if (_cache.containsKey(book)) {
      return _cache[book]!;
    }
    _cache[book] = records
        .where((element) =>
            book.words.any((word) => word == element.original.toLowerCase()))
        .toList();
    return _cache[book]!;
  }

  List<String> _getKnownRecordsByBook(Book book) {
    return book.words
        .where((element) => knownRecordsRepository.exist(element))
        .toList();
  }

  List<Record> getRecordsBySet(SetRecords set) {
    return records
        .where((element) => set.records.any((id) => id == element.id))
        .toList();
  }

  final Map<Book, int> _newWordsInBookCache = {};

  int newWordsInBook(Book book) {
    if (_newWordsInBookCache.containsKey(book)) {
      return _newWordsInBookCache[book]!;
    }

    final wordsInBook = getSavedRecordsByBook(book).toList().length +
        _getKnownRecordsByBook(book).length;
    if (book.words.isEmpty || wordsInBook == 0) return 100;
    _newWordsInBookCache[book] =
        100 - (wordsInBook / book.words.length * 100).toInt();

    return _newWordsInBookCache[book]!;
  }

  Record? getRecord(String original) {
    final fromCache = records.where((element) =>
        element.originalLowerCase == original.toLowerCase().trim());

    if (fromCache.isNotEmpty) {
      return fromCache.first;
    }
    return null;
  }

  Future resetProgress(Record record) async {
    try {
      putRecord(record.copyWith(
          step: RecordStep1(),
          lastReview: DateTime.utc(0),
          reviewInterval: 0,
          reviewNumber: 0,
          state: RecordState.newborn));
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future putRecord(Record record, {SetRecords? set}) async {
    try {
      record.id = records
          .firstWhere(
              (element) =>
                  element.originalLowerCase == record.originalLowerCase,
              orElse: () => record)
          .id;

      final body = record.toJson()..["user"] = pb.user?.id;
      if (record.id.isEmpty) {
        record.id = (await pb.client.collection(_record).create(body: body)).id;
      } else {
        await pb.client.collection(_record).update(record.id, body: body);
      }
      if (set != null) {
        set.records.add(record.id);
        setRecordsRepository.putSet(set);
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  void removeRecord(Record record, {SetRecords? set}) async {
    try {
      if (set != null) {
        set.records.removeWhere((id) => id == record.id);
        setRecordsRepository.putSet(set);
      }
      await pb.client.collection(_record).delete(record.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
