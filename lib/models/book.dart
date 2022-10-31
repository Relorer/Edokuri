import 'dart:typed_data';

import 'package:image/image.dart';

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
