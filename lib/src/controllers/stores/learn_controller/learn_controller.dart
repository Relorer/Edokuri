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

  LearnControllerBase(
      this._recordRepository, this._settingsController, this._records) {
    updateRecords();
  }

  @observable
  late Record? currentRecord;

  @action
  void markRecordEasy() {
    currentRecord!.getMarkEasy();
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordGood() {
    currentRecord!.getMarkGood();
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordHard() {
    currentRecord!.getMarkHard();
    _recordRepository.putRecord(currentRecord!);
    updateRecords();
  }

  @action
  void markRecordAgain() {
    currentRecord!.getMarkAgain();
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
}
