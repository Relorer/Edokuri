import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card/book_card.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class LibraryBookList extends StatelessWidget {
  const LibraryBookList({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<DBController>();

    return Observer(builder: (_) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, defaultMargin),
                  child: BookCard(
                    book: db.books[index],
                  ),
                ),
            childCount: db.books.length),
      );
    });
  }
}
