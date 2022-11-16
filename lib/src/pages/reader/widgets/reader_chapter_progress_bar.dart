import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class ReaderChapterProgressBar extends StatelessWidget {
  const ReaderChapterProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final reader = context.read<ReaderController>();

    return Observer(
        builder: (context) => Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(defaultRadius)),
                  child: LinearProgressIndicator(
                    value:
                        reader.completedPages / (max(reader.pageCount - 1, 1)),
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
                    value: reader.currentPage.toDouble(),
                    max: reader.pageCount.toDouble() - 1,
                    onChanged: null,
                  ),
                ),
              ],
            ));
  }
}
