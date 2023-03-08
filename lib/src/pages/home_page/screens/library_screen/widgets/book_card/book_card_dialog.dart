import 'package:edokuri/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/core/widgets/default_bottom_sheet.dart';
import 'package:edokuri/src/theme/svgs.dart';

class BookCardDialog extends StatelessWidget {
  final VoidCallback? openBook;
  final VoidCallback? openBookSet;
  final VoidCallback? removeBook;

  const BookCardDialog(
      {super.key, this.openBook, this.removeBook, this.openBookSet});

  @override
  Widget build(BuildContext context) {
    return DefaultBottomSheet(children: [
      ButtonWithIcon(
        text: LocaleKeys.continue_reading.tr(),
        onTap: openBook,
        svg: readingSvg,
      ),
      ButtonWithIcon(
        text: LocaleKeys.go_to_set.tr(),
        svg: goToSetSvg,
        onTap: openBookSet,
      ),
      ButtonWithIcon(
        text: LocaleKeys.delete.tr(),
        svg: deleteSvg,
        onTap: removeBook,
      ),
    ]);
  }
}
