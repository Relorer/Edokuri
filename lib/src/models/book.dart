import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';

@Entity()
class Book {
  int id;
  String title;
  String author;
  Uint8List? cover;
  final chapters = ToMany<Chapter>();

  Book({this.id = 0, required this.title, required this.author, this.cover});
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

final RegExp _pieceOfLineExp =
    RegExp(r"(([a-zA-Z]|('|-|’)[a-zA-Z])+(?=([^a-zA-Z]|$))|[^a-zA-Z]+)");

final RegExp _wordExp = RegExp(r"[a-zA-Z]+");

List<Paragraph> getParagraphs(String content) {
  return content
      .split("\n")
      .map((p) => Paragraph()
        ..pieces.addAll(_pieceOfLineExp
            .allMatches(p.trim())
            .map((e) => e[0])
            .where((e) => e?.isNotEmpty ?? false)
            .map((e) => Piece(content: e!, isWord: _wordExp.hasMatch(e)))))
      .toList();
}
