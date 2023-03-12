// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'activity_time.g.dart';

enum Type { reading, learning }

@JsonSerializable()
class ActivityTime {
  String id;
  String user;
  final DateTime start;
  final DateTime end;
  final Type type;

  int get timespan => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  ActivityTime(this.start, this.end, this.type, {this.id = "", this.user = ""});

  factory ActivityTime.fromRecord(RecordModel record) =>
      ActivityTime.fromJson(record.toJson());

  factory ActivityTime.fromJson(Map<String, dynamic> json) =>
      _$ActivityTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityTimeToJson(this);
}
