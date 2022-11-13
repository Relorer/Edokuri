import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/reader_controller/provider_reader_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class ReaderChapterProgressBar extends StatelessWidget {
  const ReaderChapterProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final readerController = ProviderReaderController.ctr(context);

    return Observer(
        builder: (context) => Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(defaultRadius)),
                  child: LinearProgressIndicator(
                    value: readerController.completedPages /
                        (max(readerController.pageCount - 1, 1)),
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
                      disabledThumbColor:
                          Theme.of(context).progressBarActiveColor,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 5)),
                  child: Slider(
                    value: readerController.currentPage.toDouble(),
                    max: readerController.pageCount.toDouble() - 1,
                    onChanged: null,
                  ),
                ),
              ],
            ));
  }
}
