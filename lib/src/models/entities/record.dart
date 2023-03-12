// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  String id;
  String userId;

  final List<Translation> translations;
  final List<Meaning> meanings;
  final List<Example> examples;
  final List<Example> sentences;
  final List<String> synonyms;
  final String original;
  final String originalLowerCase;
  final String transcription;
  final DateTime creationDate;
  final DateTime lastReview;

  bool known;

  String get translation => translations
      .where((element) => element.selected)
      .map((element) => element.text)
      .join(", ");

  Record({
    this.id = "",
    required this.original,
    required this.originalLowerCase,
    required this.transcription,
    required this.known,
    required this.creationDate,
    required this.examples,
    required this.meanings,
    required this.synonyms,
    required this.sentences,
    required this.translations,
    required this.lastReview,
    this.userId = "",
  });

  factory Record.fromRecord(RecordModel record) =>
      Record.fromJson(record.toJson());

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
