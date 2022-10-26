import 'dart:async';
import 'package:epubx/epubx.dart';
import 'package:freader/objectbox.g.dart';
import 'package:html/parser.dart';
import '../models/book.dart';

class EpubService {
  final RegExp pieceOfLineExp =
      RegExp(r"([a-zA-Z]+(?=([^a-zA-Z]|$))|[^a-zA-Z]+)");
  final RegExp wordExp = RegExp(r"[a-zA-Z]+");

  Future<Book> readBook(FutureOr<List<int>> bytes) async {
    var epub = await EpubReader.openBook(bytes);

    List<EpubChapterRef> chapters = [];
    for (var ch in await epub.getChapters()) {
      chapters.addAll(_getChapters(ch));
    }

    var book = Book(
        author: epub.Author ?? "no author", title: epub.Title ?? "no title");

    for (var value in chapters) {
      var doc = parse(await value.readHtmlContent());
      var content = _stripHtmlIfNeeded(doc.body!.innerHtml).trim();
      if (content.isNotEmpty) {
        book.chapters.add(Chapter()
          ..paragraphs.addAll(content.split("\n").map((p) => Paragraph()
            ..pieces.addAll(pieceOfLineExp
                .allMatches(p.trim())
                .map((e) => e[0])
                .where((e) => e?.isNotEmpty ?? false)
                .map(
                    (e) => Piece(content: e!, isWord: wordExp.hasMatch(e)))))));
      }
    }

    return book;
  }

  List<EpubChapterRef> _getChapters(EpubChapterRef chapter) {
    List<EpubChapterRef> chapters = [];

    if ((chapter.SubChapters?.length ?? 0) > 0) {
      for (var ch in chapter.SubChapters!) {
        chapters.addAll(_getChapters(ch));
      }
    } else {
      chapters.add(chapter);
    }

    return chapters;
  }

  String _stripHtmlIfNeeded(String text) {
    // The regular expression is simplified for an HTML tag (opening or
    // closing) or an HTML escape. We might want to skip over such expressions
    // when estimating the text directionality.
    return text
        .replaceAll(RegExp(r"[ \r\n]+"), ' ')
        .replaceAll(RegExp(r'<\/p>'), '\n')
        .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
}
