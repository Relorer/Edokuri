// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class ReaderFooterPanel extends StatelessWidget {
  const ReaderFooterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final reader = context.read<ReaderController>();

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: doubleDefaultMargin, vertical: defaultMargin),
      child: Observer(builder: (_) {
        int partCount = reader.chaptersContent.length;
        return Text(
          partCount > 0
              ? LocaleKeys.partOf.tr(namedArgs: {
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
