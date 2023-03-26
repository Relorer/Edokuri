// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/recordState/recordState.dart';

class StateSerializer implements JsonConverter<RecordState, String> {
  const StateSerializer();

  @override
  RecordState fromJson(String state) {
    if (state == getRecordStateString(RecordState.studied)) {
      return RecordState.studied;
    }
    if (state == getRecordStateString(RecordState.repeatable)) {
      return RecordState.repeatable;
    }
    return RecordState.recent;
  }

  @override
  String toJson(RecordState state) {
    if (getRecordStateString(state) ==
        getRecordStateString(RecordState.studied)) {
      return getRecordStateString(RecordState.studied);
    }
    if (getRecordStateString(state) ==
        getRecordStateString(RecordState.repeatable)) {
      return getRecordStateString(RecordState.repeatable);
    }
    return getRecordStateString(RecordState.recent);
  }
}
