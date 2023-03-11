class Paragraph {
  final List<Piece> pieces = [];
}

class Piece {
  String content;
  bool isWord;

  Piece({required this.content, required this.isWord});
}
