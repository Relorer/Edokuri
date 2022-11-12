import 'dart:async';
import 'dart:typed_data';
import 'package:epubx/epubx.dart';
import 'package:freader/src/core/utils/string_utils.dart';
import 'package:freader/src/models/book.dart';
import 'package:html/parser.dart';
import 'package:image/image.dart';

class EpubService {
  Future<Book> readBook(FutureOr<List<int>> bytes) async {
    var epub = await EpubReader.openBook(bytes);
    Uint8List? cover;

    var coverImage = await epub.readCover();
    if (coverImage != null) {
      cover = Uint8List.fromList(encodeJpg(coverImage));
    }

    List<EpubChapterRef> chapters = [];
    for (var ch in await epub.getChapters()) {
      chapters.addAll(_getChapters(ch));
    }

    var book = Book(
        author: epub.Author != null && epub.Author!.isNotEmpty
            ? epub.Author!
            : "no author",
        title: epub.Title != null && epub.Title!.isNotEmpty
            ? epub.Title!
            : "no title",
        cover: cover,
        currentChapter: 0,
        currentCompletedChapter: 0,
        currentPositionInChapter: 0,
        currentCompletedPositionInChapter: 0,
        words: []);

    List<String> words = [];

    for (var value in chapters) {
      var doc = parse(await value.readHtmlContent());
      var content = _stripHtmlIfNeeded(doc.body!.innerHtml).trim();
      if (content.isNotEmpty) {
        words.addAll(getAllWords(content));
        book.chapters.add(Chapter(content: content));
      }
    }

    book.words.addAll(words.toSet());

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
