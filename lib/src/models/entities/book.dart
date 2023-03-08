import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:pocketbase/pocketbase.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  String id;

  User? user;

  String? title;
  String? author;
  int currentChapter;
  int currentPositionInChapter;
  int currentCompletedChapter;
  int currentCompletedPositionInChapter;
  List<String> words;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? cover;

  final chapters = <String>[];
  List<ActivityTime> readTimes;

  Book({
    this.id = "",
    required this.title,
    required this.author,
    required this.currentChapter,
    required this.currentCompletedChapter,
    required this.currentCompletedPositionInChapter,
    required this.currentPositionInChapter,
    required this.words,
    this.cover,
    this.user,
    this.readTimes = const [],
  });

  int get readingTimeInMinutes => readTimes.isNotEmpty
      ? readTimes
              .map((element) => element.timespan)
              .reduce((t1, t2) => t1 + t2) /
          1000 ~/
          60
      : 0;

  factory Book.fromRecord(RecordModel record) => Book.fromJson(record.toJson());

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
