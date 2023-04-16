// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'known_records.g.dart';

@JsonSerializable()
class KnownRecords {
  String id;
  String user;
  final DateTime created;

  List<String> records;

  KnownRecords({
    this.id = "",
    this.user = "",
    required this.records,
    required this.created,
  });

  factory KnownRecords.fromRecord(RecordModel record) =>
      KnownRecords.fromJson(record.toJson());

  factory KnownRecords.fromJson(Map<String, dynamic> json) =>
      _$KnownRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$KnownRecordsToJson(this);
}
