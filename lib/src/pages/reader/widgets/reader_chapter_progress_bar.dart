// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

// 📦 Package imports:

class ReaderChapterProgressBar extends StatefulWidget {
  final ReaderController reader;

  const ReaderChapterProgressBar({super.key, required this.reader});

  @override
  State<ReaderChapterProgressBar> createState() =>
      _ReaderChapterProgressBarState();
}

class _ReaderChapterProgressBarState extends State<ReaderChapterProgressBar> {
  double page = 0;

  double _getPage(ReaderController reader) {
    final pageController = reader.pageController;
    final real = (pageController?.page ?? 0) -
        reader.getCompletedChaptersPageCount().toDouble();
    return max(min(real, reader.pageCount.toDouble() - 1), 0);
  }

  @override
  Widget build(BuildContext context) {
    final reader = widget.reader;
    final pageController = reader.pageController;

    if (!(pageController?.hasListeners ?? true)) {
      page = reader.currentPage.toDouble();
      pageController?.addListener(() {
        setState(() {
          page = _getPage(reader);
        });
      });
    }

    final pageCount = max(reader.pageCount.toDouble() - 1, 1);

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
          child: LinearProgressIndicator(
            value: max(
                page / pageCount,
                (reader.currentChapter == reader.currentCompletedChapter
                        ? reader.currentCompletedPage
                        : reader.currentChapter < reader.currentCompletedChapter
                            ? reader.pageCount
                            : 0) /
                    pageCount),
            color: Theme.of(context).progressBarActiveColor,
            backgroundColor: Colors.black12,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Colors.transparent,
            inactiveTrackColor: Colors.transparent,
            disabledActiveTickMarkColor: Colors.transparent,
            disabledActiveTrackColor: Colors.transparent,
            disabledInactiveTickMarkColor: Colors.transparent,
            disabledInactiveTrackColor: Colors.transparent,
            thumbColor: Theme.of(context).progressBarActiveColor,
            disabledThumbColor: Theme.of(context).progressBarActiveColor,
            overlayShape: SliderComponentShape.noOverlay,
            thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 6, elevation: 0, pressedElevation: 0),
          ),
          child: Slider(
            value: min(reader.pageCount.toDouble() - 1, page),
            max: reader.pageCount.toDouble() - 1,
            onChanged: (value) {},
            onChangeEnd: (value) {
              final completed = reader.getCompletedChaptersPageCount();
              final real = value.toInt() + completed;
              final completedPage =
                  reader.currentChapter == reader.currentCompletedChapter
                      ? reader.currentCompletedPage
                      : reader.currentChapter < reader.currentCompletedChapter
                          ? reader.pageCount
                          : 0;
              pageController?.animateToPage(
                min(real, completed + completedPage),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }
}
