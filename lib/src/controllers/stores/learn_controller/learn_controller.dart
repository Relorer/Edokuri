import 'dart:math';

import 'package:freader/src/controllers/common/settings_controller/settings_controller.dart';
import 'package:freader/src/controllers/stores/learn_controller/review_intervals.dart';
import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'learn_controller.g.dart';

class LearnController = LearnControllerBase with _$LearnController;

abstract class LearnControllerBase with Store {
  final _random = Random();
  final RecordRepository _recordRepository;
  final SettingsController _settingsController;
  final List<Record> _records;
  final List<Record> buffer = [];

  late List<Record> _currentBunch = _getNextBunch();

  LearnControllerBase(
      this._recordRepository, this._settingsController, this._records);

  @observable
  int currentRecord = 0;

  @observable
  late int bunchSize = _settingsController.packSize;

  @observable
  late bool autoPronouncing = _settingsController.autoPronouncingInLearnPage;

  @observable
  late bool definitionOn = _settingsController.frontCardInLearnPageDefinition;

  @observable
  late bool termOn = _settingsController.frontCardInLearnPageTerm;

  @computed
  int get total => min(bunchSize, _records.length);

  Record getRecordByIndex(int index) {
    final next = _currentBunch[_random.nextInt(_currentBunch.length)];

    if (buffer.length <= index) {
      buffer.add(next);
    } else if (!_currentBunch.contains(buffer[index])) {
      buffer[index] = next;
    }

    if (buffer.length - 1 == index) {
      if (index > 0 &&
          buffer[index] == buffer[index - 1] &&
          _currentBunch.length > 1) {
        buffer[index] = (_currentBunch.toList()..shuffle())
            .firstWhere((element) => element != buffer[index]);
      }
    }

    return buffer[index];
  }

  @action
  void setBunchSize(int size) {
    if (bunchSize != size) {
      bunchSize = size;
      _settingsController.setPackSize(size);
      currentRecord = 0;
      _currentBunch = _getNextBunch();
    }
  }

  @action
  void setAutoPronouncing(bool value) {
    autoPronouncing = value;
    _settingsController.setAutoPronouncingInLearnPage(value);
  }

  @action
  void setDefinitionOn(bool value) {
    definitionOn = value;
    _settingsController.setFrontCardInLearnPageDefinition(value);
  }

  @action
  void setTermOn(bool value) {
    termOn = value;
    _settingsController.setFrontCardInLearnPageTerm(value);
  }

  @action
  void answerHandler(int index, bool know) {
    final rec = getRecordByIndex(index);
    if (know) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (rec.lastReview.year == 0 ||
          (now -
                  getNextReviewTime(rec.reviewNumber) +
                  rec.lastReview.millisecondsSinceEpoch) >
              0) {
        rec.lastReview = DateTime.now();
        rec.reviewNumber++;
        _recordRepository.putRecord(rec);
      }

      _currentBunch.remove(rec);
      currentRecord++;
    } else {
      rec.reviewNumber--;
      _recordRepository.putRecord(rec);
    }
    if (currentRecord == total) {
      currentRecord = 0;
      _currentBunch = _getNextBunch();
    }
  }

  List<Record> _getNextBunch() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final sorted = _records.toList()
      ..sort((b, a) => (now -
              getNextReviewTime(a.reviewNumber) +
              a.lastReview.millisecondsSinceEpoch)
          .compareTo((now -
              getNextReviewTime(b.reviewNumber) +
              b.lastReview.millisecondsSinceEpoch)));
    return sorted.take(bunchSize).toList()..shuffle();
  }
}
