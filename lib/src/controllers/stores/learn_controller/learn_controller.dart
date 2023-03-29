// 📦 Package imports:
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
  final RecordRepository _recordRepository;
  final SettingsController _settingsController;

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

  @observable
  bool canRevertLastMark = false;

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
    //TODO
  }

  void markRecord(Record? record, Function? markRecord) {
    answerIsShown = false;
    if (record == null) {
      return;
    }
    deleteRecordFromGroup(record);
    if (markRecord != null) {
      markRecord(record);
    }
    putRecordIntoGroup(record);
    _recordRepository.putRecord(record);
    updateRecords();
  }

  void updateRecords() {
    _records.sort((Record a, Record b) {
      return a.reviewInterval - b.reviewInterval;
    });

    if (timeForReviewHasCome(_records[0])) {
      currentRecord = _records[0];
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
    return records.where((element) => timeForReviewHasCome(element)).length;
  }

  ObservableList<Record> getRecordsByState(
      List<Record> records, RecordState state) {
    return ObservableList<Record>.of(
        records.where((element) => element.state == state));
  }
}
