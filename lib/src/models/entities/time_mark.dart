// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'time_mark.g.dart';

@JsonSerializable()
class TimeMark {
  String id;
  DateTime created;
  String user;

  TimeMark({this.id = "", required this.created, this.user = ""});

  factory TimeMark.fromRecord(RecordModel record) =>
      TimeMark.fromJson(record.toJson());

  factory TimeMark.fromJson(Map<String, dynamic> json) =>
      _$TimeMarkFromJson(json);

  Map<String, dynamic> toJson() => _$TimeMarkToJson(this);
}
