// Project imports:
import 'package:edokuri/src/models/models.dart';

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

List<String> getAllWords(String content) {
  return _pieceOfLineExp
      .allMatches(content)
      .map((e) => e[0])
      .where((e) => e?.isNotEmpty ?? false)
      .map((e) => e!)
      .where((e) => _wordExp.hasMatch(e))
      .toList();
}

bool containsWord(String content) {
  return _wordExp.hasMatch(content);
}
