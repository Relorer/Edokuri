import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/generated/locale.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_content.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_cover.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_dialog.dart';
import 'package:freader/src/pages/reader/reader_page.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  openBook(BuildContext context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ReaderPage(book: book),
          ),
        )
        .then((value) => Future.delayed(const Duration(milliseconds: 100),
            () => setUpBarDefaultStyles(context)));
  }

  removeBook(BuildContext context) {
    context.read<DBController>().removeBook(book);
    Navigator.pop(context);
  }

  longPressHandler(BuildContext context) {
    showModalBottomSheet<void>(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BookCardDialog(
        bookTitle: book.title ?? LocaleKeys.no_title.tr(),
        openBook: () => openBook(context),
        removeBook: () => removeBook(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      onTap: () => openBook(context),
      onLongPress: () => longPressHandler(context),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        BookCardCover(
          cover: book.cover,
        ),
        Observer(builder: (_) {
          return BookCardContent(
            author: book.author ?? LocaleKeys.no_author.tr(),
            chaptersCount: book.chapters.length,
            currentCompletedChapter: book.currentCompletedChapter,
            title: book.title ?? LocaleKeys.no_title.tr(),
            recordsCount:
                context.read<DBController>().getSavedRecordsByBook(book).length,
            newWordsPersent: book.newWords(context.read<DBController>()),
          );
        })
      ]),
    );
  }
}
