// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/core/widgets/default_bottom_sheet.dart';
import 'package:edokuri/src/theme/svgs.dart';

class BookCardDialog extends StatelessWidget {
  final VoidCallback? openBook;
  final VoidCallback? openBookSet;
  final VoidCallback? removeBook;
  final VoidCallback? addCustomCover;
  final VoidCallback? resetProgress;

  const BookCardDialog(
      {super.key,
      this.openBook,
      this.removeBook,
      this.openBookSet,
      this.addCustomCover,
      this.resetProgress});

  @override
  Widget build(BuildContext context) {
    return DefaultBottomSheet(children: [
      ButtonWithIcon(
        text: LocaleKeys.continueReading.tr(),
        onTap: openBook,
        svg: readingSvg,
      ),
      ButtonWithIcon(
        text: LocaleKeys.goToSet.tr(),
        svg: goToSetSvg,
        onTap: openBookSet,
      ),
      ButtonWithIcon(
          text: LocaleKeys.addCustomCover.tr(),
          svg: changeCoverSvg,
          onTap: addCustomCover),
      ButtonWithIcon(
        text: "Reset progress",
        svg: loopSvg,
        onTap: resetProgress,
      ),
      ButtonWithIcon(
        text: LocaleKeys.delete.tr(),
        svg: deleteSvg,
        onTap: removeBook,
      ),
    ]);
  }
}
