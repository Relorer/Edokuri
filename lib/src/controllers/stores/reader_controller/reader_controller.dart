// 🎯 Dart imports:
import 'dart:async';
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/handle_volume_button/handle_volume_button.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/utils/string_utils.dart';
import 'package:edokuri/src/models/models.dart';

part 'reader_controller.g.dart';

class ReaderController = ReaderControllerBase with _$ReaderController;

class _PositionInBook {
  final int chapter;
  final int indexInChapter;

  _PositionInBook(this.chapter, this.indexInChapter);
}

abstract class ReaderControllerBase with Store {
  final RecordRepository recordRepository;
  final KnownRecordsRepository knownRecordsRepository;
  final BookRepository bookRepository;
  final Book book;

  PageController? pageController;

  final HandleVolumeController handleVolumeButtonController;

  void _handleVolumeButton(HardwareButton button) {
    if (button == HardwareButton.volume_down) {
      jumpToNextPage();
    } else if (button == HardwareButton.volume_up) {
      jumpToPreviousPage();
    }
  }

  void jumpToNextPage() {
    if (pageController == null) return;
    pageController!.jumpToPage(pageController!.page!.toInt() + 1);
  }

  void jumpToPreviousPage() {
    if (pageController == null) return;
    pageController!.jumpToPage(pageController!.page!.toInt() - 1);
  }

  ReaderControllerBase(
      this.recordRepository,
      this.bookRepository,
      this.knownRecordsRepository,
      this.handleVolumeButtonController,
      this.book) {
    handleVolumeButtonController.addHandler(_handleVolumeButton);
    handleVolumeButtonController.enable();
  }

  void dispose() {
    handleVolumeButtonController.disable();
    handleVolumeButtonController.removeHandler(_handleVolumeButton);
  }

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

  void _completePage(int chapter, int page) async {
    await Future.delayed(const Duration(seconds: 1));
    final words =
        await Future(() => getParagraphs(chaptersContent[chapter][page])
            .expand(
              (element) => element.pieces,
            )
            .where(
              (element) =>
                  element.isWord &&
                  recordRepository.getRecord(element.content) == null &&
                  !knownRecordsRepository.exist(element.content),
            ));
    knownRecordsRepository
        .addRecords(words.map((e) => e.content.toLowerCase()).toList());
  }

  @action
  Future loadContent(Size pageSize, TextStyle style) async {
    chaptersContent = [];
    final List<List<String>> temp = [];
    for (var element in book.chapters) {
      temp.add(await _paginate(pageSize, element, style));
    }
    currentPageIndex = currentPageIndex < 0
        ? _getPageIndexByChapterAndPosition(
            temp, book.currentChapter, book.currentPositionInChapter)
        : _getPageIndexByChapterAndPosition(temp, currentChapter,
            _getPositionInChapter(temp, currentChapter, currentPage));

    pageController = PageController(initialPage: currentPageIndex);

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

  void savePosition() {
    if (chaptersContent.isEmpty) return;

    book.currentChapter = currentChapter;
    book.currentPositionInChapter = getCurrentPositionInChapter();

    book.currentCompletedChapter = currentCompletedChapter;
    book.currentCompletedPositionInChapter =
        getCurrentCompletedPositionInChapter();
    bookRepository.putBook(book);
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

  String getSentence(int indexInSentence) {
    final chapterContent = book.chapters[currentChapter];

    final indexInSentenceInChapter =
        indexInSentence + getCurrentPositionInChapter();

    final endSentenceReg = RegExp(r'(\.|!|\?|\n)');

    final endSentence =
        chapterContent.indexOf(endSentenceReg, indexInSentenceInChapter);
    final startSentence =
        chapterContent.lastIndexOf(endSentenceReg, indexInSentenceInChapter);

    return chapterContent
        .substring(
            startSentence > -1 ? startSentence + 1 : indexInSentenceInChapter,
            endSentence > -1 ? endSentence + 1 : indexInSentenceInChapter)
        .trim();
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
