// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/settings_controller/settings_controller.dart';
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
  Record? currentRecord;

  @action
  void markRecordEasy() {
    markWordEasy(currentRecord!);
    markRecord(currentRecord!);
  }

  @action
  void markRecordGood() {
    markWordGood(currentRecord!);
    markRecord(currentRecord!);
  }

  @action
  void markRecordHard() {
    markWordHard(currentRecord!);
    markRecord(currentRecord!);
  }

  @action
  void markRecordAgain() {
    markWordAgain(currentRecord!);
    markRecord(currentRecord!);
  }

  void markRecord(Record record) {
    answerIsShown = false;
    deleteRecordFromGroup(currentRecord!);
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
    int index = findIndexById(recent, record.id);
    if (index != -1) {
      recent.removeAt(index);
      return;
    }
    index = findIndexById(studied, record.id);
    if (index != -1) {
      studied.removeAt(index);
      return;
    }
    index = findIndexById(repeatable, record.id);
    if (index != -1) {
      repeatable.removeAt(index);
      return;
    }
  }

  void putRecordIntoGroup(Record record) {
    if (record.recordState == RecordState.recent) {
      recent.add(record);
    } else if (record.recordState == RecordState.studied) {
      studied.add(record);
    } else {
      repeatable.add(record);
    }
  }

  void sortRecordsIntoGroups() {
    for (var element in _records) {
      if (element.recordState == RecordState.recent) {
        recent.add(element);
      } else if (element.recordState == RecordState.studied) {
        studied.add(element);
      } else {
        repeatable.add(element);
      }
    }
  }

  int findIndexById(List<Record> records, String id) {
    for (int i = 0; i < records.length; i++) {
      if (records[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  void markWordEasy(Record record) {
    record.recordStep.markWordEasy(record);
    record.reviewNumber++;
  }

  void markWordGood(Record record) {
    record.recordStep.markWordGood(record);
    record.reviewNumber++;
  }

  void markWordHard(Record record) {
    record.recordStep.markWordHard(record);
    record.reviewNumber++;
  }

  void markWordAgain(Record record) {
    record.recordStep.markWordAgain(record);
    record.reviewNumber++;
  }
}
