class ActivityTime {
  final DateTime start;
  final DateTime end;

  int get timespan => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  ActivityTime(
    this.start,
    this.end,
  );

  Map<String, Object?> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }

  static ActivityTime fromJson(Map<String, Object> json) {
    return ActivityTime(json['start'] as DateTime, json['end'] as DateTime);
  }
}
