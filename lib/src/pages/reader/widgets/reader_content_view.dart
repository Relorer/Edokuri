import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/reader_controller/provider_reader_controller.dart';
import 'package:freader/src/core/widgets/circular_progress_indicator_pale.dart';
import 'package:freader/src/pages/reader/widgets/bouncing_page_view.dart';

class ReaderContentView extends StatelessWidget {
  const ReaderContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final readerController = ProviderReaderController.ctr(context);

    return Observer(
      builder: (context) {
        if (readerController.chaptersContent.isEmpty) {
          return const CircularProgressIndicatorPale();
        }
        return BouncingPageView(
          onPageChanged: readerController.pageChangedHandler,
          pageController:
              PageController(initialPage: readerController.currentPageIndex),
          pagesContent:
              readerController.chaptersContent.expand((x) => x).toList(),
        );
      },
    );
  }
}
