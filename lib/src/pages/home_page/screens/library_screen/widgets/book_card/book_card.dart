// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/controllers/stores/set_controller/set_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/simple_card.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_content.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_cover.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_dialog.dart';
import 'package:edokuri/src/pages/reader/reader_page.dart';
import 'package:edokuri/src/pages/set_page/set_page.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  void _openBook(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ReaderPage(book: book);
      }),
    );
  }

  void _removeBook(BuildContext context) {
    context.read<BookRepository>().removeBook(book);
    getIt<ToastController>().showDefaultTost("Book is removed");
    Navigator.pop(context);
  }

  void _openBookSet(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Observer(builder: (_) {
          return SetPage(
            setData: SetData(
                context.read<RecordRepository>().getSavedRecordsByBook(book)),
          );
        }),
      ),
    );
  }

  void _longPressHandler(BuildContext context) {
    showModalBottomSheet<void>(
      barrierColor: Colors.black26,
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
            author: book.author ?? LocaleKeys.noAuthor.tr(),
            chaptersCount: book.chapters.length,
            currentCompletedChapter: book.currentCompletedChapter,
            title: book.title ?? LocaleKeys.noTitle.tr(),
            recordsCount: context
                .read<RecordRepository>()
                .getSavedRecordsByBook(book)
                .length,
            newWordsPercent:
                context.read<RecordRepository>().newWordsInBook(book),
          );
        })
      ]),
    );
  }
}
