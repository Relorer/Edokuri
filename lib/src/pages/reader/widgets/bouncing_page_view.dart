// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme_consts.dart';
import 'reader_content_view_page/reader_content_view_page.dart';

class BouncingPageView extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int>? onPageChanged;

  final List<String> pagesContent;

  const BouncingPageView(
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
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: 0),
          child: Center(
              child: ReaderContentViewPage(content: pagesContent[index])),
        );
      },
    );
  }
}
