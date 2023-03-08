import 'package:pocketbase/pocketbase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_mark.g.dart';

@JsonSerializable()
class TimeMark {
  String id;
  DateTime dateTime;

  TimeMark({
    this.id = "",
    required this.dateTime,
  });

  factory TimeMark.fromRecord(RecordModel record) =>
      TimeMark.fromJson(record.toJson());

  factory TimeMark.fromJson(Map<String, dynamic> json) =>
      _$TimeMarkFromJson(json);

  Map<String, dynamic> toJson() => _$TimeMarkToJson(this);
}
