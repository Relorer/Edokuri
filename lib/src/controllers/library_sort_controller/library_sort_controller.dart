import 'package:freader/generated/locale.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:mobx/mobx.dart';

part 'library_sort_controller.g.dart';

enum SortTypes { amountNewWords, name, progress, recent }

String getSortTypeName(SortTypes type) {
  switch (type) {
    case SortTypes.amountNewWords:
      return LocaleKeys.amount_of_new_words.tr();
    case SortTypes.name:
      return LocaleKeys.name.tr();
    case SortTypes.progress:
      return LocaleKeys.progress.tr();
    case SortTypes.recent:
      return LocaleKeys.recent.tr();
  }
}

class LibrarySortController = LibrarySortControllerBase
    with _$LibrarySortController;

abstract class LibrarySortControllerBase with Store {
  final DBController db;

  @observable
  SortTypes sortType = SortTypes.recent;

  LibrarySortControllerBase(this.db);

  @computed
  String get sortTypeName => getSortTypeName(sortType);

  @action
  void setSortType(SortTypes? type) {
    sortType = type ?? SortTypes.recent;
  }

  List<Book> sort(List<Book> books) {
    switch (sortType) {
      case SortTypes.amountNewWords:
        return books.toList()
          ..sort((b1, b2) => b1.newWords(db).compareTo(b2.newWords(db)));
      case SortTypes.name:
        return books.toList()
          ..sort((b1, b2) =>
              (b1.title ?? "no title").compareTo((b2.title ?? "no title")));
      case SortTypes.progress:
        return books.toList()
          ..sort((b1, b2) => (b2.currentCompletedChapter / b2.chapters.length)
              .compareTo(b1.currentCompletedChapter / b1.chapters.length));
      case SortTypes.recent:
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
