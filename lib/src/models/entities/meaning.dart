// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'meaning.g.dart';

@JsonSerializable()
class Meaning {
  String id;
  String pos;
  String user;

  String description;

  List<String> meanings;

  bool hasMeanings() => meanings.isNotEmpty;

  List<String> examples;

  bool hasExamples() => examples.isNotEmpty;

  Meaning(this.pos, this.description, this.meanings, this.examples,
      {this.id = "", this.user = ""});

  factory Meaning.fromRecord(RecordModel record) =>
      Meaning.fromJson(record.toJson());

  factory Meaning.fromJson(Map<String, dynamic> json) =>
      _$MeaningFromJson(json);

  Map<String, dynamic> toJson() => _$MeaningToJson(this);
}
