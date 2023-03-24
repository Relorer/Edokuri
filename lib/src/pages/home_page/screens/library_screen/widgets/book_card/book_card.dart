// 🐦 Flutter imports:
import 'dart:typed_data';

import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/simple_card.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_content.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_cover.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card_dialog.dart';
import 'package:edokuri/src/pages/reader/reader_page.dart';
import 'package:edokuri/src/pages/set_page/set_page.dart';
import 'package:image_picker/image_picker.dart';

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
    getIt<BookRepository>().removeBook(book);
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
                getIt<RecordRepository>().getSavedRecordsByBook(book),
                set: SetRecords(name: book.title ?? LocaleKeys.noTitle.tr())),
          );
        }),
      ),
    );
  }

  void _addCustomCover(BuildContext context) async {
    Navigator.pop(context);
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    final Uint8List bytes = await file!.readAsBytes();
    book.cover = bytes;
    await getIt<BookRepository>().updateBookCover(book);
    getIt<ToastController>().showDefaultTost("Cover is changed");
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
        addCustomCover: () => _addCustomCover(context),
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
            recordsCount:
                getIt<RecordRepository>().getSavedRecordsByBook(book).length,
            newWordsPercent: getIt<RecordRepository>().newWordsInBook(book),
          );
        })
      ]),
    );
  }
}
