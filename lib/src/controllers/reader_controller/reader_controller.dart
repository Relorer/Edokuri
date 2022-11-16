import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:mobx/mobx.dart';

part 'reader_controller.g.dart';

class ReaderController = ReaderControllerBase with _$ReaderController;

class _PositionInBook {
  final int chapter;
  final int indexInChapter;

  _PositionInBook(this.chapter, this.indexInChapter);
}

abstract class ReaderControllerBase with Store {
  final DBController dbController;

  ReaderControllerBase(this.dbController);

  @observable
  int pageCount = 1;

  int currentPageIndex = -1;

  @observable
  int currentChapter = 0;

  @observable
  int currentPage = 0;

  int currentCompletedPageIndex = -1;

  @observable
  int currentCompletedChapter = 0;

  @observable
  int currentCompletedPage = 0;

  @computed
  int get completedPages => currentCompletedChapter > currentChapter
      ? pageCount
      : currentCompletedChapter < currentChapter
          ? 0
          : currentCompletedPage;

  @observable
  List<List<String>> chaptersContent = [];

  int getCurrentPositionInChapter() {
    return _getPositionInChapter(chaptersContent, currentChapter, currentPage);
  }

  int getCurrentCompletedPositionInChapter() {
    return _getPositionInChapter(
        chaptersContent, currentCompletedChapter, currentCompletedPage);
  }

  int _getPositionInChapter(
      List<List<String>> chapters, int chapter, int page) {
    var position = 0;
    for (var i = 0; i < page; i++) {
      position += chapters[chapter][i].length;
    }
    return position;
  }

  _PositionInBook _getPositionInBook(List<List<String>> chapters, int index) {
    var sumPages = 0;
    for (var element in chapters) {
      sumPages += element.length;
      if (index < sumPages) {
        return _PositionInBook(
            chapters.indexOf(element), index - sumPages + element.length);
      }
    }

    throw Exception("Index out of range");
  }

  @action
  void pageChangedHandler(int index) {
    final newPosition = _getPositionInBook(chaptersContent, index);

    currentChapter = newPosition.chapter;
    currentPage = newPosition.indexInChapter;
    pageCount = chaptersContent[newPosition.chapter].length;

    if (currentCompletedChapter < currentChapter) {
      currentCompletedChapter = currentChapter;
      currentCompletedPage = currentPage;
      _completePage(
          currentChapter - 1, chaptersContent[currentChapter - 1].length - 1);
    } else if (currentCompletedChapter == currentChapter &&
        currentCompletedPage < currentPage) {
      currentCompletedPage = currentPage;
      _completePage(currentChapter, currentPage - 1);
    }
  }

  void _completePage(int chapter, int page) {
    print(chaptersContent[chapter][page]);
  }

  @action
  Future loadContent(Book book, Size pageSize, TextStyle style) async {
    chaptersContent = [];
    final List<List<String>> temp = [];
    for (var element in book.chapters) {
      temp.add(await _paginate(pageSize, element.content, style));
    }
    currentPageIndex = currentPageIndex < 0
        ? _getPageIndexByChapterAndPosition(
            temp, book.currentChapter, book.currentPositionInChapter)
        : _getPageIndexByChapterAndPosition(temp, currentChapter,
            _getPositionInChapter(temp, currentChapter, currentPage));

    currentCompletedPageIndex = currentCompletedPageIndex < 0
        ? _getPageIndexByChapterAndPosition(temp, book.currentCompletedChapter,
            book.currentCompletedPositionInChapter)
        : _getPageIndexByChapterAndPosition(
            temp,
            currentCompletedChapter,
            _getPositionInChapter(
                temp, currentCompletedChapter, currentCompletedPage));

    var completedPosition = _getPositionInBook(temp, currentCompletedPageIndex);

    currentCompletedChapter = completedPosition.chapter;
    currentCompletedPage = completedPosition.indexInChapter;

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

  Future<List<String>> _paginate(
      Size pageSize, String content, TextStyle style) async {
    return Future(() {
      final result = <String>[];

      final pageHeight = pageSize.height - 20;

      final textSpan = TextSpan(text: content, style: style);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: pageSize.width - 40,
      );

      List<LineMetrics> lines = textPainter.computeLineMetrics();
      double currentPageBottom = pageHeight;
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
          currentPageBottom = top + pageHeight;
        }
      }

      final lastPageText = content.substring(currentPageStartIndex);
      result.add(lastPageText);

      return result;
    });
  }
}
