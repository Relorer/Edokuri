// 🎯 Dart imports:
import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

// 📦 Package imports:
import 'package:crypto/crypto.dart';
import 'package:epubx/epubx.dart';
import 'package:html/parser.dart';
import 'package:image/image.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/utils/string_utils.dart';
import 'package:edokuri/src/models/models.dart';

class EpubService {
  Future<Book> readBook(FutureOr<List<int>> bytes) async {
    var epub = await EpubReader.openBook(bytes);
    Uint8List? cover;

    try {
      var coverImage = await epub.readCover();
      if (coverImage != null) {
        cover = Uint8List.fromList(encodeJpg(coverImage));
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }

    List<EpubChapterRef> chapters = [];
    for (var ch in await epub.getChapters()) {
      chapters.addAll(_getChapters(ch));
    }

    List<int> loadedBytes;
    if (bytes is Future) {
      loadedBytes = await bytes;
    } else {
      loadedBytes = bytes;
    }
    final hash = sha1.convert(loadedBytes);

    var book = Book(
        author: epub.AuthorList?.where((element) => element != null).join(", "),
        title: epub.Title,
        cover: cover,
        currentChapter: 0,
        currentCompletedChapter: 0,
        currentPositionInChapter: 0,
        currentCompletedPositionInChapter: 0,
        lastReading: DateTime(0),
        hash: hash.toString());

    List<String> words = [];

    for (var value in chapters) {
      var doc = parse(await value.readHtmlContent());
      var content = _stripHtmlIfNeeded(doc.body!.innerHtml).trim();
      if (content.isNotEmpty) {
        words.addAll(getAllWords(content));
        book.chapters.add(content);
      }
    }

    book.words.addAll(words.toSet().map((e) => e.toLowerCase()));

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
