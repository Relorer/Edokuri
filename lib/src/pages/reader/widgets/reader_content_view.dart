import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/core/widgets/circular_progress_indicator_pale.dart';
import 'package:edokuri/src/pages/reader/widgets/bouncing_page_view.dart';
import 'package:provider/provider.dart';

class ReaderContentView extends StatelessWidget {
  const ReaderContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final readerController = context.read<ReaderController>();

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
