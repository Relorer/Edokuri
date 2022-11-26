import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/generated/locale.dart';
import 'package:freader/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_content.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_cover.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_dialog.dart';
import 'package:freader/src/pages/reader/reader_page.dart';
import 'package:freader/src/pages/set_page/set_page.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  void _openBook(BuildContext context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ReaderPage(book: book),
          ),
        )
        .then((value) => Future.delayed(const Duration(milliseconds: 100),
            () => setUpBarDefaultStyles(context)));
  }

  void _removeBook(BuildContext context) {
    context.read<BookRepository>().removeBook(book);
    Navigator.pop(context);
  }

  void _openBookSet(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPage(
          records: context.read<RecordRepository>().getSavedRecordsByBook(book),
        ),
      ),
    );
  }

  void _longPressHandler(BuildContext context) {
    showModalBottomSheet<void>(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BookCardDialog(
        openBook: () => _openBook(context),
        removeBook: () => _removeBook(context),
        openBookSet: () => _openBookSet(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      onTap: () => _openBook(context),
      onLongPress: () => _longPressHandler(context),
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
            recordsCount: context
                .read<RecordRepository>()
                .getSavedRecordsByBook(book)
                .length,
            newWordsPersent:
                context.read<RecordRepository>().newWordsInBook(book),
          );
        })
      ]),
    );
  }
}
