// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/settings_controller/settings_controller.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/review_intervals.dart';
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/models/entities/record.dart';

part 'learn_controller.g.dart';

class LearnController = LearnControllerBase with _$LearnController;

abstract class LearnControllerBase with Store {
  final RecordRepository _recordRepository;
  final SettingsController _settingsController;
  final List<Record> _records;
  bool answerIsShown = false;
  late List<Record> recent = <Record>[];
  late List<Record> studied = <Record>[];
  late List<Record> repeatable = <Record>[];

  LearnControllerBase(
      this._recordRepository, this._settingsController, this._records) {
    updateRecords();
    putRecordsIntoGroups();
  }

  @observable
  late Record? currentRecord = null;

  @action
  void markRecordEasy() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.getMarkEasy();
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordGood() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.getMarkGood();
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordHard() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.getMarkHard();
    putRecordIntoGroup(currentRecord!);
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordAgain() {
    deleteRecordFromGroup(currentRecord!);
    currentRecord!.getMarkAgain();
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

  void deleteRecordFromGroup(Record record){
    if (record.recordState == RecordState.recent){
      recent.remove(record);
    }
    if (record.recordState == RecordState.studied){
      studied.remove(record);
    }
    repeatable.remove(record);
  }

  void putRecordIntoGroup(Record record){
    if (record.recordState == RecordState.recent){
      recent.add(record);
    }
    if (record.recordState == RecordState.studied){
      studied.add(record);
    }
    repeatable.add(record);
  }

  void putRecordsIntoGroups(){
    _records.forEach((element) {
      if (element.recordState == RecordState.recent){
        recent.add(element);
      }
      if (element.recordState == RecordState.studied){
        studied.add(element);
      }
      repeatable.add(element);
    });
  }
}
