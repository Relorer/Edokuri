import 'package:pocketbase/pocketbase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable()
class Example {
  String id;

  final String text;
  final String tr;

  Example(this.text, this.tr, {this.id = ""});

  factory Example.fromRecord(RecordModel record) =>
      Example.fromJson(record.toJson());

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
