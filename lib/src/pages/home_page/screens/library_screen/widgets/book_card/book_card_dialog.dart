import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class BookCardDialog extends StatelessWidget {
  final String bookTitle;

  final VoidCallback? openBook;
  final VoidCallback? openBookSet;
  final VoidCallback? removeBook;

  const BookCardDialog(
      {super.key,
      required this.bookTitle,
      this.openBook,
      this.removeBook,
      this.openBookSet});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(defaultRadius),
        topRight: Radius.circular(defaultRadius),
      ),
      child: Container(
        color: Theme.of(context).secondBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
            const SizedBox(
              height: 55,
            )
          ],
        ),
      ),
    );
  }
}
