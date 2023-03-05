class ActivityTime {
  String id;
  final DateTime start;
  final DateTime end;

  int get timespan => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  ActivityTime(this.start, this.end, {this.id = ''});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'start': start,
      'end': end,
    };
  }

  static ActivityTime fromJson(Map<String, Object> json) {
    return ActivityTime(
      json['start'] as DateTime,
      json['end'] as DateTime,
      id: json['id'] as String,
    );
  }
}
