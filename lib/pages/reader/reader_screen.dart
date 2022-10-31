import 'package:flutter/material.dart';
import 'package:freader/models/book_indexes.dart';
import 'dart:math';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/models/book.dart';
import 'package:freader/widgets/slider_widget.dart';

import 'widgets/reader_slider_widget.dart';

class ReaderScreen extends StatefulWidget {
  final Chapter chapter;

  const ReaderScreen({
    required this.chapter,
    Key? key,
  }) : super(key: key);

  @override
  ReaderScreenState createState() {
    return ReaderScreenState();
  }
}

class ReaderScreenState extends State<ReaderScreen> {
  final List<String> _pages = [];
  final _containerKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => _paginate());
    super.initState();
  }

  void _paginate() {
    final pageSize =
        (_containerKey.currentContext?.findRenderObject() as RenderBox).size;

    _pages.clear();

    var content = widget.chapter.content.replaceAll("\n", "\n\n");

    final textSpan = TextSpan(
        text: content,
        style: const TextStyle(fontSize: 19, wordSpacing: 2, height: 1.6));
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: pageSize.width,
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
        _pages.add(pageText);
        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + pageSize.height;
      }
    }

    final lastPageText = content.substring(currentPageStartIndex);
    setState(() {
      _pages.add(lastPageText);
    });
  }

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();

    return Column(
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("close")),
            Expanded(
                child: SliderWidget(
              initValue: 0,
              max: max(_pages.length, 1),
              onChanged: (index) {
                print(index);
                if (buttonCarouselController.ready) {
                  buttonCarouselController.jumpToPage(index);
                }
              },
            )),
          ],
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              key: _containerKey,
              child: _pages.isEmpty
                  ? Container()
                  : ReaderSliderWidget(
                      pages: _pages,
                      carouselController: buttonCarouselController,
                      onPageChanged: ((index, reason) {}),
                    )),
        )
      ],
    );
  }
}

class WordIndexWithKey {
  final WordIndex wordIndex;
  final GlobalKey<State<StatefulWidget>> key;

  WordIndexWithKey(this.wordIndex, this.key);
}
