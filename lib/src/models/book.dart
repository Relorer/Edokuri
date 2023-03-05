import 'dart:typed_data';

class Book {
  String id;
  String? title;
  String? author;
  int currentChapter;
  int currentPositionInChapter;
  int currentCompletedChapter;
  int currentCompletedPositionInChapter;
  List<String> words;
  String? fileId;
  Uint8List? cover;

  List<String> chapters = [];

  Book(
      {required this.title,
      required this.author,
      required this.currentChapter,
      required this.currentCompletedChapter,
      required this.currentCompletedPositionInChapter,
      required this.currentPositionInChapter,
      required this.words,
      this.cover,
      this.fileId,
      this.id = ''});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'currentChapter': currentChapter,
      'currentCompletedChapter': currentCompletedChapter,
      'currentCompletedPositionInChapter': currentCompletedPositionInChapter,
      'words': words,
      'cover': cover?.map((e) => e).toList(),
      'fileId': fileId
    };
  }

  static Book fromJson(Map<String, Object> json) {
    return Book(
      title: json['title'] as String,
      author: json['author'] as String,
      currentChapter: json['currentChapter'] as int,
      currentCompletedChapter: json['currentCompletedChapter'] as int,
      currentCompletedPositionInChapter:
          json['currentCompletedPositionInChapter'] as int,
      currentPositionInChapter: json['currentPositionInChapter'] as int,
      words: json['words'] as List<String>,
      cover: json['cover'] as Uint8List,
      fileId: json['fileId'] as String,
      id: json['id'] as String,
    );
  }
}

class Paragraph {
  final List<Piece> pieces = [];
}

class Piece {
  String content;
  bool isWord;

  Piece({required this.content, required this.isWord});
}
