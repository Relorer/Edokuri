import 'package:objectbox/objectbox.dart';

@Entity()
class Book {
  int id;
  String title;
  String author;
  final chapters = ToMany<Chapter>();

  Book({this.id = 0, required this.title, required this.author});
}

@Entity()
class Chapter {
  int id;
  final paragraphs = ToMany<Paragraph>();

  Chapter({this.id = 0});
}

@Entity()
class Paragraph {
  int id;
  final pieces = ToMany<Piece>();

  Paragraph({this.id = 0});
}

@Entity()
class Piece {
  int id;
  String content;
  bool isWord;

  Piece({this.id = 0, required this.content, required this.isWord});
}
