import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';

@Entity()
class Book {
  int id;
  String? title;
  String? author;
  int currentChapter;
  int currentPositionInChapter;
  int currentCompletedChapter;
  int currentCompletedPositionInChapter;
  List<String> words;

  Uint8List? cover;

  final chapters = ToMany<Chapter>();

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
}

@Entity()
class Chapter {
  int id;
  String content;

  Chapter({this.id = 0, required this.content});
}

class Paragraph {
  final List<Piece> pieces = [];
}

class Piece {
  String content;
  bool isWord;

  Piece({required this.content, required this.isWord});
}
