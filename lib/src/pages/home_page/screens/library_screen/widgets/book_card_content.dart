import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/ellipsis_text.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card_progress_bar.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class BookCardContent extends StatelessWidget {
  final String title;
  final String author;
  final int currentCompletedChapter;
  final int chaptersCount;

  const BookCardContent(
      {super.key,
      required this.author,
      required this.chaptersCount,
      required this.currentCompletedChapter,
      required this.title});

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
              style: Theme.of(context).bookAuthorStyle,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BookCardProgressBar(
              current: currentCompletedChapter,
              max: chaptersCount - 1,
            ),
            const SizedBox(
              height: defaultMargin * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EllipsisText(
                  LocaleKeys.records.tr(namedArgs: {"count": 145.toString()}),
                  style: Theme.of(context).bookSubInfoStyle,
                ),
                EllipsisText(
                  LocaleKeys.new_words
                      .tr(namedArgs: {"persent": 10.toString()}),
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
