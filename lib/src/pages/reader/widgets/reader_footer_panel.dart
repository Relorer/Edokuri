import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class ReaderFooterPanel extends StatelessWidget {
  final int currentPart;
  final int partCount;

  const ReaderFooterPanel(
      {super.key, required this.currentPart, required this.partCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: doubleDefaultMargin, vertical: defaultMargin),
      child: Observer(builder: (_) {
        return Text(
          "Part $currentPart of $partCount",
          style: Theme.of(context).readerFooterPanelTextStyle,
        );
      }),
    );
  }
}
