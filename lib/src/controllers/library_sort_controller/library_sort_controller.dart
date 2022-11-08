import 'package:mobx/mobx.dart';

part 'library_sort_controller.g.dart';

enum SortTypes { amountNewWords, name, progress, recent }

String getSortTypeName(SortTypes type) {
  switch (type) {
    case SortTypes.amountNewWords:
      return "Amount of new words";
    case SortTypes.name:
      return "Name";
    case SortTypes.progress:
      return "Progress";
    case SortTypes.recent:
      return "Recent";
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
  void setSortType(SortTypes type) {
    sortType = type;
  }
}
