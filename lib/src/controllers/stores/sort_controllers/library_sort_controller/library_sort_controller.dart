import 'package:freader/generated/locale.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/base_sort_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:mobx/mobx.dart';

part 'library_sort_controller.g.dart';

enum BooksSortTypes { amountNewWords, name, progress, recent }

class LibrarySortController = LibrarySortControllerBase
    with _$LibrarySortController;

abstract class LibrarySortControllerBase
    extends BaseSortController<BooksSortTypes, Book> with Store {
  final DBController db;

  @override
  @observable
  BooksSortTypes sortType = BooksSortTypes.recent;

  LibrarySortControllerBase(this.db);

  @override
  @computed
  String get sortTypeName => getSortTypeName(sortType);

  @override
  String getSortTypeName(BooksSortTypes type) {
    switch (type) {
      case BooksSortTypes.amountNewWords:
        return LocaleKeys.amount_of_new_words.tr();
      case BooksSortTypes.name:
        return LocaleKeys.name.tr();
      case BooksSortTypes.progress:
        return LocaleKeys.progress.tr();
      case BooksSortTypes.recent:
        return LocaleKeys.recent.tr();
    }
  }

  @override
  @action
  void setSortType(BooksSortTypes? type) {
    sortType = type ?? BooksSortTypes.recent;
  }

  @override
  List<Book> sort(List<Book> books) {
    switch (sortType) {
      case BooksSortTypes.amountNewWords:
        return books.toList()
          ..sort((b1, b2) => b1.newWords(db).compareTo(b2.newWords(db)));
      case BooksSortTypes.name:
        return books.toList()
          ..sort((b1, b2) =>
              (b1.title ?? "no title").compareTo((b2.title ?? "no title")));
      case BooksSortTypes.progress:
        return books.toList()
          ..sort((b1, b2) => (b2.currentCompletedChapter / b2.chapters.length)
              .compareTo(b1.currentCompletedChapter / b1.chapters.length));
      case BooksSortTypes.recent:
        return books.toList()
          ..sort((b1, b2) =>
              (b2.readTimes.isNotEmpty ? b2.readTimes.last.end : DateTime(0))
                  .compareTo(b1.readTimes.isNotEmpty
                      ? b1.readTimes.last.end
                      : DateTime(0)));
      default:
    }

    throw Exception("Index out of range");
  }
}
