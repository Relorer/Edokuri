import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/base_sort_controller.dart';
import 'package:freader/src/models/record.dart';
import 'package:mobx/mobx.dart';
part 'record_sort_controller.g.dart';

enum RecordsSortTypes { alphabetically }

class RecordsSortController = RecordsSortControllerBase
    with _$RecordsSortController;

abstract class RecordsSortControllerBase
    extends BaseSortController<RecordsSortTypes, Record> with Store {
  final DBController db;

  @override
  @observable
  RecordsSortTypes sortType = RecordsSortTypes.alphabetically;

  RecordsSortControllerBase(this.db);

  @override
  @computed
  String get sortTypeName => getSortTypeName(sortType);

  @override
  String getSortTypeName(RecordsSortTypes type) {
    switch (type) {
      case RecordsSortTypes.alphabetically:
        return "Alphabetically";
    }
  }

  @override
  @action
  void setSortType(RecordsSortTypes? type) {
    sortType = type ?? RecordsSortTypes.alphabetically;
  }

  @override
  List<Record> sort(List<Record> records) {
    switch (sortType) {
      case RecordsSortTypes.alphabetically:
        return records.toList()
          ..sort((b1, b2) =>
              b1.original.toLowerCase().compareTo(b2.original.toLowerCase()));

      default:
    }

    throw Exception("Index out of range");
  }
}
