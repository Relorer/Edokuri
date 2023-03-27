// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/recordStep/recordStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep1.dart';
import 'package:edokuri/src/models/recordStep/recordStep2.dart';
import 'package:edokuri/src/models/recordStep/recordStep3.dart';
import 'package:edokuri/src/models/recordStep/recordStep4.dart';

class StepSerializer implements JsonConverter<RecordStep, String> {
  const StepSerializer();

  @override
  RecordStep fromJson(String step) {
    if (step == "firstStep") {
      return RecordStep1();
    }
    if (step == "secondStep") {
      return RecordStep2();
    }
    if (step == "thirdStep") {
      return RecordStep3();
    }
    return RecordStep4();
  }

  @override
  String toJson(RecordStep step) {
    if (step is RecordStep1) {
      return "firstStep";
    }
    if (step is RecordStep2) {
      return "secondStep";
    }
    if (step is RecordStep3) {
      return "thirdStep";
    }
    return "foursStep";
  }
}
