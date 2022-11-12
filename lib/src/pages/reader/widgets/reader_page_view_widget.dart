import 'package:flutter/material.dart';
import 'package:freader/src/pages/reader/widgets/reader_page_widget.dart';

class ReaderChapterPageView extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int>? onPageChanged;

  final List<String> pagesContent;

  const ReaderChapterPageView(
      {super.key,
      required this.pagesContent,
      required this.pageController,
      required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPageChanged,
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: pagesContent.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(child: ReaderPageWidget(content: pagesContent[index])),
        );
      },
    );
  }
}
