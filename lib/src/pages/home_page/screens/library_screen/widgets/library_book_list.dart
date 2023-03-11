// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LibraryBookList extends StatelessWidget {
  const LibraryBookList({super.key});

  @override
  Widget build(BuildContext context) {
    final bookRepository = getIt<BookRepository>();

    return Observer(builder: (_) {
      final books = getIt<LibrarySortController>().sort(bookRepository.books);

      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, defaultMargin),
                  child: BookCard(
                    book: books[index],
                  ),
                ),
            childCount: books.length),
      );
    });
  }
}
