class TimeMark {
  DateTime mark;

  TimeMark(this.mark);

  Map<String, Object?> toJson() {
    return {
      'mark': mark,
    };
  }

  static TimeMark fromJson(Map<String, Object> json) {
    return TimeMark(
      json['mark'] as DateTime,
    );
  }
}
