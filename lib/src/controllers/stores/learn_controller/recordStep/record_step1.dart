// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step2.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step4.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

class RecordStep1 extends RecordStep {
  RecordStep1();

  RecordStep1.withRecord(super.record) : super.withRecord();

  // easy
  @override
  int get easyNextInterval => fourDays;

  @override
  RecordState get easyNextState => RecordState.repeatable;

  @override
  RecordStep get easyNextStep => RecordStep4.withRecord(record);

  // good
  @override
  int get goodNextInterval => tenMinutes;

  @override
  RecordState get goodNextState => RecordState.studied;

  @override
  RecordStep get goodNextStep => RecordStep2.withRecord(record);

  // hard
  @override
  int get hardNextInterval => sixMinutes;

  @override
  RecordState get hardNextState => RecordState.studied;

  @override
  RecordStep get hardNextStep => this;

  // again
  @override
  int get againNextInterval => oneMinute;

  @override
  RecordState get againNextState => RecordState.studied;

  @override
  RecordStep get againNextStep => RecordStep1.withRecord(record);
}
