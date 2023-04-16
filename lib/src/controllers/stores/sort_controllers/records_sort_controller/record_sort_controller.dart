// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/base_sort_controller.dart';
import 'package:edokuri/src/models/models.dart';

part 'record_sort_controller.g.dart';

enum RecordsSortTypes { alphabetically, recent }

class RecordsSortController = RecordsSortControllerBase
    with _$RecordsSortController;

abstract class RecordsSortControllerBase
    extends BaseSortController<RecordsSortTypes, Record> with Store {
  final RecordRepository recordRepository;

  @override
  @observable
  RecordsSortTypes sortType = RecordsSortTypes.recent;

  RecordsSortControllerBase(this.recordRepository);

  @override
  @computed
  String get sortTypeName => getSortTypeName(sortType);

  @override
  String getSortTypeName(RecordsSortTypes type) {
    switch (type) {
      case RecordsSortTypes.alphabetically:
        return "Alphabetically";
      case RecordsSortTypes.recent:
        return "Recent";
    }
  }

  @override
  @action
  void setSortType(RecordsSortTypes? type) {
    sortType = type ?? RecordsSortTypes.alphabetically;
  }

  @override
  List<Record> sort(List<Record> types) {
    switch (sortType) {
      case RecordsSortTypes.alphabetically:
        return types.toList()
          ..sort((b1, b2) =>
              b1.original.toLowerCase().compareTo(b2.original.toLowerCase()));
      case RecordsSortTypes.recent:
        return types.toList()
          ..sort((b1, b2) => b2.created.compareTo(b1.created));
    }
  }
}
