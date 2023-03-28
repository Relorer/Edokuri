// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step1.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step3.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step4.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

class RecordStep2 extends RecordStep {
  RecordStep2();

  RecordStep2.withRecord(super.record) : super.withRecord();

  // easy
  @override
  int get easyNextInterval => fourDays;

  @override
  RecordState get easyNextState => RecordState.repeatable;

  @override
  RecordStep get easyNextStep => RecordStep4.withRecord(record);

  // good
  @override
  int get goodNextInterval => oneDay;

  @override
  RecordState get goodNextState => RecordState.studied;

  @override
  RecordStep get goodNextStep => RecordStep3.withRecord(record);

  // hard
  @override
  int get hardNextInterval => tenMinutes;

  @override
  RecordState get hardNextState => RecordState.studied;

  @override
  RecordStep get hardNextStep => RecordStep1.withRecord(record);

  // again
  @override
  int get againNextInterval => oneMinute;

  @override
  RecordState get againNextState => RecordState.studied;

  @override
  RecordStep get againNextStep => RecordStep1.withRecord(record);
}
