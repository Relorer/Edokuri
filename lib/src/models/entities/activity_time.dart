import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'activity_time.g.dart';

@JsonSerializable()
class ActivityTime {
  String id;
  final DateTime start;
  final DateTime end;

  int get timespan => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  ActivityTime(
    this.start,
    this.end, {
    this.id = "",
  });

  factory ActivityTime.fromRecord(RecordModel record) =>
      ActivityTime.fromJson(record.toJson());

  factory ActivityTime.fromJson(Map<String, dynamic> json) =>
      _$ActivityTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityTimeToJson(this);
}
