import 'dart:typed_data';

import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Book {
  int id;

  final user = ToOne<User>();

  String? title;
  String? author;
  int currentChapter;
  int currentPositionInChapter;
  int currentCompletedChapter;
  int currentCompletedPositionInChapter;
  List<String> words;

  Uint8List? cover;

  final chapters = ToMany<Chapter>();
  final readTimes = ToMany<ReadTime>();

  Book({
    this.id = 0,
    required this.title,
    required this.author,
    required this.currentChapter,
    required this.currentCompletedChapter,
    required this.currentCompletedPositionInChapter,
    required this.currentPositionInChapter,
    required this.words,
    this.cover,
  });

  int newWords(DBController db) {
    return 100 -
        (db.getRecordsByBook(this).length / words.length * 100).toInt();
  }

  int get readingTimeInMinutes => readTimes.isNotEmpty
      ? readTimes
              .map((element) => element.timespan)
              .reduce((t1, t2) => t1 + t2) /
          1000 ~/
          60
      : 0;
}

@Entity()
class Chapter {
  int id;
  String content;

  Chapter({this.id = 0, required this.content});
}

@Entity()
class ReadTime {
  int id;
  final DateTime start;
  final DateTime end;

  int get timespan => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  ReadTime(
    this.start,
    this.end, {
    this.id = 0,
  });
}

class Paragraph {
  final List<Piece> pieces = [];
}

class Piece {
  String content;
  bool isWord;

  Piece({required this.content, required this.isWord});
}
