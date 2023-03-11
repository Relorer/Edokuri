// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'example.g.dart';

@JsonSerializable()
class Example {
  final String text;
  final String tr;

  Example(this.text, this.tr);

  factory Example.fromRecord(RecordModel record) =>
      Example.fromJson(record.toJson());

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
