// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class ReaderChapterProgressBar extends StatefulWidget {
  const ReaderChapterProgressBar({super.key});

  @override
  State<ReaderChapterProgressBar> createState() =>
      _ReaderChapterProgressBarState();
}

class _ReaderChapterProgressBarState extends State<ReaderChapterProgressBar> {
  double page = 0;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final reader = context.read<ReaderController>();
      final pageController = reader.pageController;
      if (!(pageController?.hasListeners ?? true)) {
        pageController?.addListener(() {
          setState(() {
            final real = (pageController.page ?? 0) -
                reader.getCompletedChaptersPageCount().toDouble();
            page = max(min(real, reader.pageCount.toDouble() - 1), 0);
          });
        });
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(defaultRadius)),
            child: LinearProgressIndicator(
              value: reader.completedPages / (max(reader.pageCount - 1, 1)),
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
              value: page,
              max: reader.pageCount.toDouble() - 1,
              onChanged: (value) {},
              onChangeEnd: (value) {
                final completed = reader.getCompletedChaptersPageCount();
                final real = value.toInt() + completed;
                pageController?.animateToPage(
                  min(real, completed + reader.currentCompletedPage),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
