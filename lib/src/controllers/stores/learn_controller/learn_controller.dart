// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/models/entities/record.dart';
import 'package:edokuri/src/models/recordState/recordState.dart';

part 'learn_controller.g.dart';

class LearnController = LearnControllerBase with _$LearnController;

abstract class LearnControllerBase with Store {
  final RecordRepository _recordRepository;
  final SettingsController _settingsController;
  final List<Record> _records;
  late List<Record> recent = <Record>[];
  late List<Record> studied = <Record>[];
  late List<Record> repeatable = <Record>[];

  LearnControllerBase(
      this._recordRepository, this._settingsController, this._records) {
    updateRecords();
    recent = _records
        .where((element) => element.recordState == RecordState.recent)
        .toList();
    studied = _records
        .where((element) => element.recordState == RecordState.studied)
        .toList();
    repeatable = _records
        .where((element) => element.recordState == RecordState.repeatable)
        .toList();
  }

  @observable
  bool answerIsShown = false;

  @observable
  Record? currentRecord;

  @action
  void markRecordEasy() {
    markRecord(currentRecord!, currentRecord!.recordStep.markWordEasy);
  }

  @action
  void markRecordGood() {
    markRecord(currentRecord!, currentRecord!.recordStep.markWordGood);
  }

  @action
  void markRecordHard() {
    markRecord(currentRecord!, currentRecord!.recordStep.markWordHard);
  }

  @action
  void markRecordAgain() {
    markRecord(currentRecord!, currentRecord!.recordStep.markWordAgain);
  }

  void markRecord(Record record, Function markRecord) {
    answerIsShown = false;
    deleteRecordFromGroup(currentRecord!);
    markRecord(record);
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
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
    switch (record.recordState) {
      case RecordState.recent:
        recent.remove(record);
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
    switch (record.recordState) {
      case RecordState.recent:
        recent.add(record);
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
