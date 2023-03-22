// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/recordStep/firstStep.dart';
import 'package:edokuri/src/models/recordStep/foursStep.dart';
import 'package:edokuri/src/models/recordStep/recordStep.dart';
import 'package:edokuri/src/models/recordStep/secondStep.dart';
import 'package:edokuri/src/models/recordStep/thirdStep.dart';

class StepSerializer implements JsonConverter<RecordStep, String> {
  const StepSerializer();

  @override
  RecordStep fromJson(String step) {
    if (step == "firstStep") {
      return FirstStep();
    }
    if (step == "secondStep") {
      return SecondStep();
    }
    if (step == "thirdStep") {
      return ThirdStep();
    }
    return FoursStep();
  }

  @override
  String toJson(RecordStep step) {
    if (step is FirstStep) {
      return "firstStep";
    }
    if (step is SecondStep) {
      return "secondStep";
    }
    if (step is ThirdStep) {
      return "thirdStep";
    }
    return "foursStep";
  }
}
