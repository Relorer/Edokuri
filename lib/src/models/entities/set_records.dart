// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'set_records.g.dart';

@JsonSerializable()
class SetRecords {
  String id;
  String user;

  String name;

  List<String> records;

  SetRecords(
      {this.id = "",
      required this.name,
      this.records = const [],
      this.user = ""});

  factory SetRecords.fromRecord(RecordModel record) =>
      SetRecords.fromJson(record.toJson());

  factory SetRecords.fromJson(Map<String, dynamic> json) =>
      _$SetRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$SetRecordsToJson(this);
}
