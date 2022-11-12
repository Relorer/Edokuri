import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:freader/src/models/book.dart';
import 'package:mobx/mobx.dart';

part 'reader_controller.g.dart';

class ReaderController = ReaderControllerBase with _$ReaderController;

abstract class ReaderControllerBase with Store {
  int currentPageIndex = -1;

  @observable
  int currentChapter = 0;

  @observable
  int pageCount = 1;

  @observable
  int currentPage = 0;

  @observable
  int completedPages = 0;

  @observable
  List<List<String>> chaptersContent = [];

  int getCurrentPositionInChapter() {
    return _getPositionInChapter(chaptersContent);
  }

  int _getPositionInChapter(List<List<String>> chapters) {
    var position = 0;
    for (var i = 0; i < currentPage; i++) {
      position += chapters[currentChapter][i].length;
    }
    return position;
  }

  void pageChangedHandler(int index) {
    currentPageIndex = index;
    var sumPages = 0;
    for (var element in chaptersContent) {
      sumPages += element.length;
      if (index < sumPages) {
        _updatePosition(element, index, sumPages);
        break;
      }
    }
  }

  @action
  void _updatePosition(List<String> chapter, int index, int sumPages) {
    currentChapter = chaptersContent.indexOf(chapter);
    currentPage = index - sumPages + chapter.length;
    completedPages = currentPage;
    pageCount = chapter.length;
  }

  @action
  Future loadContent(Book book, Size pageSize) async {
    chaptersContent = [];
    final List<List<String>> temp = [];
    for (var element in book.chapters) {
      temp.add(await _paginate(pageSize, element.content));
    }
    print(book.currentPositionInChapter);
    print(book.currentPositionInChapter);
    print(book.currentPositionInChapter);
    print(book.currentPositionInChapter);
    currentPageIndex = currentPageIndex < 0
        ? _getPageIndexByChapterAndPosition(
            temp, book.currentChapter, book.currentPositionInChapter)
        : _getPageIndexByChapterAndPosition(
            temp, currentChapter, _getPositionInChapter(temp));
    chaptersContent = temp;
    pageChangedHandler(currentPageIndex);
  }

  int _getPageIndexByChapterAndPosition(
      List<List<String>> chaptersContent, int chapter, int position) {
    var index = 0;
    for (var i = 0; i < chapter; i++) {
      index += chaptersContent[i].length;
    }

    var currentPosition = 0;
    for (var element in chaptersContent[chapter]) {
      currentPosition += element.length;
      if (position < currentPosition) {
        break;
      }
      index++;
    }

    return index;
  }

  Future<List<String>> _paginate(Size pageSize, String content) async {
    return Future(() {
      final result = <String>[];

      final textSpan = TextSpan(
          text: content,
          style: const TextStyle(fontSize: 18, wordSpacing: 2, height: 1.6));
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: pageSize.width - 40,
      );

      List<LineMetrics> lines = textPainter.computeLineMetrics();
      double currentPageBottom = pageSize.height;
      int currentPageStartIndex = 0;
      int currentPageEndIndex = 0;

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];

        final left = line.left;
        final top = line.baseline - line.ascent;
        final bottom = line.baseline + line.descent;

        if (currentPageBottom < bottom) {
          currentPageEndIndex =
              textPainter.getPositionForOffset(Offset(left, top)).offset;
          final pageText =
              content.substring(currentPageStartIndex, currentPageEndIndex);
          result.add(pageText);
          currentPageStartIndex = currentPageEndIndex;
          currentPageBottom = top + pageSize.height;
        }
      }

      final lastPageText = content.substring(currentPageStartIndex);
      result.add(lastPageText);

      return result;
    });
  }
}
