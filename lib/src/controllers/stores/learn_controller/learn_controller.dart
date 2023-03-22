// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/settings_controller/settings_controller.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/review_intervals.dart';
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
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
    sortRecordsIntoGroups();
  }

  @observable
  bool answerIsShown = false;

  @observable
  late Record? currentRecord = null;

  @action
  void markRecordEasy() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.markWordEasy();
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordGood() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.markWordGood();
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordHard() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.markWordHard();
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordAgain() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.markWordAgain();
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  void updateRecords() {
    _records.sort(Record.compareTo);

    if (timeForReviewHasCome(_records[0])) {
      currentRecord = _records[0];
    } else {
      currentRecord = null;
    }
  }

  void deleteRecordFromGroup(Record record) {
    if (record.recordState == RecordState.recent) {
      recent.remove(record);
    }
    else if (record.recordState == RecordState.studied) {
      studied.remove(record);
    }
    else {
      repeatable.remove(record);
    }
  }

  void putRecordIntoGroup(Record record) {
    if (record.recordState == RecordState.recent) {
      recent.add(record);
    }
    else if (record.recordState == RecordState.studied) {
      studied.add(record);
    }
    else {
      repeatable.add(record);
    }
  }

  void sortRecordsIntoGroups() {
    for (var element in _records) {
      if (element.recordState == RecordState.recent) {
        recent.add(element);
      }
      else if (element.recordState == RecordState.studied) {
        studied.add(element);
      }
      else {
        repeatable.add(element);
      }
    }
  }
}
