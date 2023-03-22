enum RecordState {
  recent,
  studied,
  repeatable,
}

String getRecordStateString(RecordState state) {
  return state.toString().split('.').last;
}
