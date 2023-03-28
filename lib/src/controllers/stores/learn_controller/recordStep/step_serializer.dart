// 🎯 Dart imports:
import 'dart:core';

// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step1.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step2.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step3.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/recordStep/record_step4.dart';

class StepSerializer implements JsonConverter<RecordStep, String> {
  const StepSerializer();

  @override
  RecordStep fromJson(String step) {
    if (step == "step1") {
      return RecordStep1();
    }
    if (step == "step2") {
      return RecordStep2();
    }
    if (step == "step3") {
      return RecordStep3();
    }
    return RecordStep4();
  }

  @override
  String toJson(RecordStep step) {
    if (step is RecordStep1) {
      return "step1";
    }
    if (step is RecordStep2) {
      return "step2";
    }
    if (step is RecordStep3) {
      return "step3";
    }
    return "step4";
  }
}
