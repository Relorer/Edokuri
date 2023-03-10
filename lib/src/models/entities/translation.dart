// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'translation.g.dart';

@JsonSerializable()
class Translation {
  final String text;
  final String source;
  bool selected;
  DateTime? selectionDate;

  Translation(
    this.text, {
    this.selected = false,
    required this.source,
    this.selectionDate,
  });

  factory Translation.fromRecord(RecordModel record) =>
      Translation.fromJson(record.toJson());

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}
