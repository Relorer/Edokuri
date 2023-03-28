// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';

part 'learn_controller.g.dart';

class LearnController = LearnControllerBase with _$LearnController;

abstract class LearnControllerBase with Store {
  final RecordRepository _recordRepository;
  final SettingsController _settingsController;

  final List<Record> _records;
  late List<Record> newborn = <Record>[];
  late List<Record> studied = <Record>[];
  late List<Record> repeatable = <Record>[];

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
  String get newbornCount => newborn.length.toString();

  @computed
  String get studiedCount => studied.length.toString();

  @computed
  String get repeatableCount => repeatable.length.toString();

  @computed
  RecordState get currentRecordState =>
      currentRecord?.state ?? RecordState.newborn;

  LearnControllerBase(
      this._recordRepository, this._settingsController, this._records) {
    updateRecords();
    newborn = _records
        .where((element) => element.state == RecordState.newborn)
        .toList();
    studied = _records
        .where((element) => element.state == RecordState.studied)
        .toList();
    repeatable = _records
        .where((element) => element.state == RecordState.repeatable)
        .toList();
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
}
