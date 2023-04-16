// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'activity_time.g.dart';

enum Type { reading, learning }

@JsonSerializable()
class ActivityTime {
  String id;
  String user;
  final DateTime created;
  final int timeSpan;
  final Type type;

  ActivityTime(this.timeSpan, this.created, this.type,
      {this.id = "", this.user = ""});

  factory ActivityTime.fromRecord(RecordModel record) =>
      ActivityTime.fromJson(record.toJson());

  factory ActivityTime.fromJson(Map<String, dynamic> json) =>
      _$ActivityTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityTimeToJson(this);
}
