// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/core/widgets/ellipsis_text.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_progress_bar.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class BookCardContent extends StatelessWidget {
  final String title;
  final String author;
  final int currentCompletedChapter;
  final int chaptersCount;
  final int newWordsPersent;
  final int recordsCount;

  const BookCardContent(
      {super.key,
      required this.author,
      required this.chaptersCount,
      required this.currentCompletedChapter,
      required this.title,
      required this.newWordsPersent,
      required this.recordsCount});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EllipsisText(
              title,
              style: Theme.of(context).bookTitleStyle,
            ),
            EllipsisText(
              author,
              style: Theme.of(context).cardSubtitleStyle,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BookCardProgressBar(
              current: currentCompletedChapter,
              max: chaptersCount,
            ),
            const SizedBox(
              height: defaultMargin * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EllipsisText(
                  LocaleKeys.records
                      .tr(namedArgs: {"count": recordsCount.toString()}),
                  style: Theme.of(context).bookSubInfoStyle,
                ),
                EllipsisText(
                  LocaleKeys.newWords
                      .tr(namedArgs: {"persent": newWordsPersent.toString()}),
                  style: Theme.of(context).bookSubInfoStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
