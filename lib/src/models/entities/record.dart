import 'package:freader/src/models/models.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  String id;
  User? user;

  final List<SetRecords> sets;

  final List<Translation> translations;
  final List<Meaning> meanings;
  final List<Example> examples;
  final List<Example> sentences;
  final List<String> synonyms;
  final String original;
  final String originalLowerCase;
  final String transcription;
  final DateTime creationDate;

  bool known;

  String get translation => translations
      .where((element) => element.selected)
      .map((element) => element.text)
      .join(", ");

  Record(
      {this.id = "",
      required this.original,
      required this.originalLowerCase,
      required this.transcription,
      required this.synonyms,
      required this.known,
      required this.creationDate,
      this.examples = const [],
      this.meanings = const [],
      this.sentences = const [],
      this.sets = const [],
      this.translations = const [],
      this.user});

  factory Record.fromRecord(RecordModel record) =>
      Record.fromJson(record.toJson());

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
