import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../models/book.dart';
import '../../models/book_indexes.dart';
import 'word_widget.dart';

class ChapterReaderWidget extends StatefulWidget {
  final Chapter chapter;

  const ChapterReaderWidget({Key? key, required this.chapter})
      : super(key: key);

  @override
  State<ChapterReaderWidget> createState() => _ChapterReaderWidgetState();
}

class _ChapterReaderWidgetState extends State<ChapterReaderWidget> {
  late final List<PageIndex> _pageIndexes;
  int _currentPage = 0;

  final _containerKey = GlobalKey();
  final List<WordIndexWithKey> _piecesKeys = [];

  late final List<Paragraph> paragraphs;

  PageIndex _getPageWithFullContent() => PageIndex(WordIndex(0, 0),
      WordIndex(paragraphs.length - 1, paragraphs.last.pieces.length - 1));

  bool _isLoading = true;

  @override
  void initState() {
    paragraphs = widget.chapter.paragraphs.take(50).toList();

    _pageIndexes = [_getPageWithFullContent()];

    for (var i = 0; i < paragraphs.length; i++) {
      for (var j = 0; j < paragraphs[i].pieces.length; j++) {
        _piecesKeys.add(WordIndexWithKey(WordIndex(i, j), GlobalKey()));
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((_) => _paginate());
    super.initState();
  }

  void _paginate() {
    final container =
        _containerKey.currentContext?.findRenderObject() as RenderBox;

    final List<PageIndex> tempPageIndexes = [];
    var startIndex = _piecesKeys.first.wordIndex;
    var endIndex = startIndex;

    const reserveSpace = 100;

    double positionEndPrevPage = 0;
    double prevPieceBottomPositionOnPage = 0;

    for (var pieceKey in _piecesKeys) {
      final piece =
          pieceKey.key.currentContext?.findRenderObject() as RenderBox;

      final pieceBottomPositionOnPage =
          piece.localToGlobal(Offset.zero, ancestor: container).dy +
              piece.size.height;

      if (pieceBottomPositionOnPage - positionEndPrevPage + reserveSpace <
          container.size.height) {
        endIndex = pieceKey.wordIndex;
      } else {
        positionEndPrevPage = prevPieceBottomPositionOnPage;
        tempPageIndexes.add(PageIndex(startIndex, endIndex));
        startIndex = pieceKey.wordIndex;
      }

      prevPieceBottomPositionOnPage = pieceBottomPositionOnPage;
    }

    setState(() {
      if (tempPageIndexes.isNotEmpty) {
        _pageIndexes.clear();
        _pageIndexes.addAll(tempPageIndexes);
      }

      _piecesKeys.clear();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var keyIndex = 0;
    getKey() =>
        _piecesKeys.length > keyIndex ? _piecesKeys[keyIndex++].key : null;

    var start = _pageIndexes[_currentPage].start;
    var end = _pageIndexes[_currentPage].end;

    var startParagraph = paragraphs[start.paragraph];
    var endParagraph = paragraphs[end.paragraph];

    return Column(
      children: [
        Expanded(
          child: Container(
            key: _containerKey,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: paragraphs
                  .getRange(start.paragraph, end.paragraph + 1)
                  .map((para) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                            spacing: 2,
                            runSpacing: 6,
                            children: para.pieces
                                .getRange(
                                    startParagraph == para ? start.piece : 0,
                                    endParagraph == para
                                        ? end.piece + 1
                                        : para.pieces.length)
                                .map((piece) => piece.isWord
                                    ? WordWidget(
                                        key: getKey(),
                                        onTap: () {
                                          dev.log(piece.content);
                                        },
                                        word: piece,
                                      )
                                    : Container(
                                        key: getKey(),
                                        child: Text(
                                          piece.content,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ))
                                .toList()),
                      ))
                  .toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _currentPage = max(_currentPage - 1, 0);
                });
              },
              child: const Text("Prev"),
            ),
            Text((_currentPage + 1).toString()),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentPage = min(_currentPage + 1, _pageIndexes.length - 1);
                });
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ],
    );
  }
}

class WordIndexWithKey {
  final WordIndex wordIndex;
  final GlobalKey<State<StatefulWidget>> key;

  WordIndexWithKey(this.wordIndex, this.key);
}
