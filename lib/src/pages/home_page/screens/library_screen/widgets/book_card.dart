import 'package:flutter/material.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card_content.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card_cover.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card_dialog.dart';
import 'package:freader/src/pages/reader/reader_page.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';

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
        .then((value) => setUpBarDefaultStyles(context));
  }

  removeBook(BuildContext context) {
    ProviderDbController.ctr(context).removeBook(book);
    Navigator.pop(context);
  }

  longPressHandler(BuildContext context) {
    showModalBottomSheet<void>(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BookCardDialog(
        bookTitle: book.title,
        openBook: () => openBook(context),
        removeBook: () => removeBook(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(0),
      child: InkWell(
        highlightColor: Theme.of(context).secondBackgroundColor.withAlpha(40),
        splashColor: Theme.of(context).secondBackgroundColor.withAlpha(30),
        onTap: () => openBook(context),
        onLongPress: () => longPressHandler(context),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          BookCardCover(
            cover: book.cover,
          ),
          BookCardContent(
            author: book.author,
            chaptersCount: book.chapters.length,
            currentCompletedChapter: book.currentCompletedChapter,
            title: book.title,
          )
        ]),
      ),
    );
  }
}
