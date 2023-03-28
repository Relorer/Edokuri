// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/recordState/record_state.dart';

class StateSerializer implements JsonConverter<RecordState, String> {
  const StateSerializer();

  @override
  RecordState fromJson(String state) {
    return RecordState.values
        .firstWhere((e) => e.toString() == 'RecordState.$state');
  }

  @override
  String toJson(RecordState state) {
    return state.toString().split('.').last;
  }
}
