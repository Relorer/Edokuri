// 🎯 Dart imports:
import 'dart:typed_data';

// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  String id;

  String user;

  String? title;
  String? author;
  int currentChapter;
  int currentPositionInChapter;
  int currentCompletedChapter;
  int currentCompletedPositionInChapter;

  List<String> readTimes;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? cover;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final words = <String>[];

  @JsonKey(includeFromJson: false, includeToJson: false)
  final chapters = <String>[];

  Book({
    this.id = "",
    required this.title,
    required this.author,
    required this.currentChapter,
    required this.currentCompletedChapter,
    required this.currentCompletedPositionInChapter,
    required this.currentPositionInChapter,
    this.cover,
    this.user = "",
    this.readTimes = const [],
  });

  int get readingTimeInMinutes => readTimes.isNotEmpty
      ? readTimes
              .map((element) => 1) // element.timespan TODO
              .reduce((t1, t2) => t1 + t2) /
          1000 ~/
          60
      : 0;

  factory Book.fromRecord(RecordModel record) => Book.fromJson(record.toJson());

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
