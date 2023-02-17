import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class ReaderFooterPanel extends StatelessWidget {
  const ReaderFooterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final reader = context.read<ReaderController>();
    const double bottomMargin = 40;

    return Padding(
      padding: const EdgeInsets.only(
          top: doubleDefaultMargin,
          bottom: bottomMargin,
          left: defaultMargin,
          right: defaultMargin),
      child: Observer(builder: (_) {
        int partCount = reader.chaptersContent.length;
        return Text(
          partCount > 0
              ? LocaleKeys.part_of.tr(namedArgs: {
                  "currentPart": (reader.currentChapter + 1).toString(),
                  "partCount": (partCount).toString()
                })
              : "",
          style: Theme.of(context).readerFooterPanelTextStyle,
        );
      }),
    );
  }
}
