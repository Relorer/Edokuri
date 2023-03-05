class TimeMark {
  String id;
  DateTime mark;

  TimeMark(this.mark, {this.id = ''});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'mark': mark,
    };
  }

  static TimeMark fromJson(Map<String, dynamic> json) {
    return TimeMark(
      json['mark'] as DateTime,
      id: json['id'] as String,
    );
  }
}
