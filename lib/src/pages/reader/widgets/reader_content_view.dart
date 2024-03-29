// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/core/widgets/circular_progress_indicator_pale.dart';
import 'package:edokuri/src/pages/reader/widgets/bouncing_page_view.dart';

class ReaderContentView extends StatelessWidget {
  const ReaderContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final readerController = context.read<ReaderController>();

    return Observer(
      builder: (context) {
        if (readerController.chaptersContent.isEmpty ||
            readerController.pageController == null) {
          return const CircularProgressIndicatorPale();
        }
        return BouncingPageView(
          onPageChanged: readerController.pageChangedHandler,
          pageController: readerController.pageController!,
          pagesContent:
              readerController.chaptersContent.expand((x) => x).toList(),
        );
      },
    );
  }
}
