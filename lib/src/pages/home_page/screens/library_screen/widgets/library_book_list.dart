// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_add_button.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/book_card/book_card.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LibraryBookList extends StatelessWidget {
  const LibraryBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final bookRepository = getIt<BookRepository>();
      final books = getIt<LibrarySortController>().sort(bookRepository.books);

      if (bookRepository.isLoading && books.isEmpty) {
        return const SliverToBoxAdapter();
      }

      return books.isEmpty
          ? const BookAddButton()
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultMargin, 0, defaultMargin, defaultMargin),
                        child: BookCard(
                          key: ValueKey(books[index].id),
                          book: books[index],
                        ),
                      ),
                  childCount: books.length),
            );
    });
  }
}
