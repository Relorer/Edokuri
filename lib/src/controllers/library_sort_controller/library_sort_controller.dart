import 'package:freader/generated/locale.dart';
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
  @observable
  SortTypes sortType = SortTypes.recent;

  @computed
  String get sortTypeName => getSortTypeName(sortType);

  @action
  void setSortType(SortTypes? type) {
    sortType = type ?? SortTypes.recent;
  }
}
