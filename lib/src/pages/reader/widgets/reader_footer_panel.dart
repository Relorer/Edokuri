import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class ReaderFooterPanel extends StatelessWidget {
  const ReaderFooterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final reader = context.read<ReaderController>();

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: doubleDefaultMargin, vertical: defaultMargin),
      child: Observer(builder: (_) {
        return Text(
          LocaleKeys.part_of.tr(namedArgs: {
            "currentPart": (reader.currentChapter + 1).toString(),
            "partCount": (reader.chaptersContent.length).toString()
          }),
          style: Theme.of(context).readerFooterPanelTextStyle,
        );
      }),
    );
  }
}
