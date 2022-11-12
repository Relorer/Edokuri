import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/reader_controller/provider_reader_controller.dart';

class ReaderChapterProgressBar extends StatelessWidget {
  const ReaderChapterProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: LinearProgressIndicator(
                    value: ProviderReaderController.ctr(context)
                            .completedPages /
                        (max(
                            ProviderReaderController.ctr(context).pageCount - 1,
                            1)),
                    color: Color(0xffF2A922),
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
                      disabledThumbColor: const Color(0xffF2A922),
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 5)),
                  child: Slider(
                    value: ProviderReaderController.ctr(context)
                        .currentPage
                        .toDouble(),
                    max: ProviderReaderController.ctr(context)
                            .pageCount
                            .toDouble() -
                        1,
                    onChanged: null,
                  ),
                ),
              ],
            ));
  }
}
