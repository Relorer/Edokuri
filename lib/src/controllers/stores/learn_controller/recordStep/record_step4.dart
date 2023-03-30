// 🎯 Dart imports:
import 'dart:math';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step1.dart';
import 'package:edokuri/src/core/utils/random_utils.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

Random random = Random();
const double _mutation = 1.1;

class RecordStep4 extends RecordStep {
  final double _hardCoef = 1.2;
  final double _easyCoef = 1.3;
  final double _goodCoef = 2.5;

  RecordStep4();

  RecordStep4.withRecord(super.record) : super.withRecord();

  // easy
  @override
  int get easyNextInterval => (record.reviewInterval *
          _easyCoef *
          _goodCoef *
          doubleInRange(random, 1, _mutation))
      .toInt();

  @override
  RecordState get easyNextState => RecordState.repeatable;

  @override
  RecordStep get easyNextStep => this;

  // good
  @override
  int get goodNextInterval =>
      (record.reviewInterval * _goodCoef * doubleInRange(random, 1, _mutation))
          .toInt();

  @override
  RecordState get goodNextState => RecordState.repeatable;

  @override
  RecordStep get goodNextStep => this;

  // hard
  @override
  int get hardNextInterval =>
      (record.reviewInterval * _hardCoef * doubleInRange(random, 1, _mutation))
          .toInt();

  @override
  RecordState get hardNextState => RecordState.repeatable;

  @override
  RecordStep get hardNextStep => this;

  // again
  @override
  int get againNextInterval => tenMinutes;

  @override
  RecordState get againNextState => RecordState.studied;

  @override
  RecordStep get againNextStep => RecordStep1.withRecord(record);
}
