import 'package:flutter/material.dart';
import 'package:freader/src/pages/reader/widgets/reader_page_widget.dart';

class ReaderChapterPageView extends StatelessWidget {
  final PageController pageController;

  final List<String> pagesContent;
  final bool isFirstChapter;
  final bool isLastChapter;

  final VoidCallback moveNext;
  final VoidCallback movePrev;

  const ReaderChapterPageView(
      {super.key,
      required this.pagesContent,
      required this.isFirstChapter,
      required this.isLastChapter,
      required this.moveNext,
      required this.movePrev,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ...pagesContent.map((e) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: ReaderPageWidget(content: e),
          ))
    ];

    if (!isFirstChapter) {
      pages.insert(
          0,
          TextButton(
              onPressed: () {
                movePrev();
              },
              child: Text("Prev")));
    }

    if (!isLastChapter) {
      pages.add(TextButton(
          onPressed: () {
            moveNext();
          },
          child: Text("Next")));
    }

    return PageView.builder(
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int index) {
        return pages[index];
      },
    );
  }
}
