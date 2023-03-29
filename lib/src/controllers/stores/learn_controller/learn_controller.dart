// 📦 Package imports:
import 'dart:math';

import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';

part 'learn_controller.g.dart';

class LearnController = LearnControllerBase with _$LearnController;

const int lookIntoFuture = 20;
const int lookIntoFutureMilliseconds = lookIntoFuture * 60 * 1000;

abstract class LearnControllerBase with Store {
  final Random random = Random();
  // random number between 0 and 100
  // if this number is less than "beforeStudied", then we show newborn records
  // if this number is less than 'beforeRepeatable', then we show studied records
  // otherwise we show repeatable records
  final int beforeStudied = 10;
  final int beforeRepeatable = 55;

  final RecordRepository _recordRepository;
  final SettingsController _settingsController;

  @observable
  Record? backupRecord;
  Record? backupRecordLink;

  final List<Record> _records;

  @observable
  late ObservableList<Record> newborn =
      getRecordsByState(_records, RecordState.newborn);

  @observable
  late ObservableList<Record> studied =
      getRecordsByState(_records, RecordState.studied);

  @observable
  late ObservableList<Record> repeatable =
      getRecordsByState(_records, RecordState.repeatable);

  @observable
  bool answerIsShown = false;

  @computed
  bool get canRevertLastMark => backupRecord != null;

  @observable
  Record? currentRecord;

  @computed
  String get easyText => currentRecord?.step.easyNextIntervalText ?? "";

  @computed
  String get goodText => currentRecord?.step.goodNextIntervalText ?? "";

  @computed
  String get hardText => currentRecord?.step.hardNextIntervalText ?? "";

  @computed
  String get againText => currentRecord?.step.againNextIntervalText ?? "";

  @computed
  String get newbornCount => getCountRecordsForReview(newborn).toString();

  @computed
  String get studiedCount => getCountRecordsForReview(studied).toString();

  @computed
  String get repeatableCount => getCountRecordsForReview(repeatable).toString();

  @computed
  RecordState get currentRecordState =>
      currentRecord?.state ?? RecordState.newborn;

  LearnControllerBase(
      this._recordRepository, this._settingsController, this._records) {
    updateRecords();
  }

  @action
  void markRecordEasy() {
    markRecord(currentRecord, currentRecord?.step.markWordEasy);
  }

  @action
  void markRecordGood() {
    markRecord(currentRecord, currentRecord?.step.markWordGood);
  }

  @action
  void markRecordHard() {
    markRecord(currentRecord, currentRecord?.step.markWordHard);
  }

  @action
  void markRecordAgain() {
    markRecord(currentRecord, currentRecord?.step.markWordAgain);
  }

  @action
  void revertLastMark() {
    if (backupRecord == null || backupRecordLink == null) {
      return;
    }
    deleteRecordFromGroup(backupRecordLink!);
    putRecordIntoGroup(backupRecord!);
    _recordRepository.putRecord(backupRecord!);
    currentRecord = backupRecord;
    backupRecord = null;
    answerIsShown = true;
  }

  void markRecord(Record? record, Function? markRecord) {
    answerIsShown = false;
    if (record == null) {
      return;
    }
    backupRecord = record.copyWith();
    backupRecordLink = record;
    deleteRecordFromGroup(record);
    updateRecords();
    if (markRecord != null) {
      markRecord(record);
    }
    putRecordIntoGroup(record);
    _recordRepository.putRecord(record);
    if (currentRecord == null) {
      updateRecords();
    }
  }

  void updateRecords() {
    newborn.sort((Record a, Record b) {
      return timeToReview(a) - timeToReview(b);
    });

    studied.sort((Record a, Record b) {
      return timeToReview(a) - timeToReview(b);
    });

    repeatable.sort((Record a, Record b) {
      return timeToReview(a) - timeToReview(b);
    });

    final number = random.nextInt(100);
    if (number < beforeStudied &&
        newborn.isNotEmpty &&
        timeForReviewHasCome(newborn.first)) {
      currentRecord = newborn.first;
    } else if (number < beforeRepeatable &&
        studied.isNotEmpty &&
        timeForReviewHasCome(studied.first)) {
      currentRecord = studied.first;
    } else if (repeatable.isNotEmpty &&
        timeForReviewHasCome(repeatable.first)) {
      currentRecord = repeatable.first;
    } else if (studied.isNotEmpty && timeForReviewHasCome(studied.first)) {
      currentRecord = studied.first;
    } else if (newborn.isNotEmpty && timeForReviewHasCome(newborn.first)) {
      currentRecord = newborn.first;
    } else if (repeatable.isNotEmpty &&
        timeForReviewHasComeWithLookIntoFuture(repeatable.first)) {
      currentRecord = repeatable.first;
    } else if (studied.isNotEmpty &&
        timeForReviewHasComeWithLookIntoFuture(studied.first)) {
      currentRecord = studied.first;
    } else if (newborn.isNotEmpty &&
        timeForReviewHasComeWithLookIntoFuture(newborn.first)) {
      currentRecord = newborn.first;
    } else {
      currentRecord = null;
    }
  }

  void deleteRecordFromGroup(Record record) {
    switch (record.state) {
      case RecordState.newborn:
        newborn.remove(record);
        break;
      case RecordState.studied:
        studied.remove(record);
        break;
      case RecordState.repeatable:
        repeatable.remove(record);
        break;
    }
  }

  void putRecordIntoGroup(Record record) {
    switch (record.state) {
      case RecordState.newborn:
        newborn.add(record);
        break;
      case RecordState.studied:
        studied.add(record);
        break;
      case RecordState.repeatable:
        repeatable.add(record);
        break;
    }
  }

  int getCountRecordsForReview(List<Record> records) {
    return records
        .where((element) => timeForReviewHasComeWithLookIntoFuture(element))
        .length;
  }

  ObservableList<Record> getRecordsByState(
      List<Record> records, RecordState state) {
    return ObservableList<Record>.of(
        records.where((element) => element.state == state));
  }
}
