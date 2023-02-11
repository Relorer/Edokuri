import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:freader/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class LibraryBookList extends StatelessWidget {
  const LibraryBookList({super.key});

  @override
  Widget build(BuildContext context) {
    final bookRepository = context.read<BookRepository>();

    return Observer(builder: (_) {
      final books =
          context.read<LibrarySortController>().sort(bookRepository.books);

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
