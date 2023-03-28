// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step1.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step4.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';

class RecordStep3 extends RecordStep {
  RecordStep3();

  RecordStep3.withRecord(super.record) : super.withRecord();

  // easy
  @override
  int get easyNextInterval => fourDays;

  @override
  RecordState get easyNextState => RecordState.repeatable;

  @override
  RecordStep get easyNextStep => RecordStep4.withRecord(record);

  // good
  @override
  int get goodNextInterval => threeDays;

  @override
  RecordState get goodNextState => RecordState.repeatable;

  @override
  RecordStep get goodNextStep => RecordStep4.withRecord(record);

  // hard
  @override
  int get hardNextInterval => twoDays;

  @override
  RecordState get hardNextState => RecordState.studied;

  @override
  RecordStep get hardNextStep => RecordStep1.withRecord(record);

  // again
  @override
  int get againNextInterval => tenMinutes;

  @override
  RecordState get againNextState => RecordState.studied;

  @override
  RecordStep get againNextStep => RecordStep1.withRecord(record);
}
