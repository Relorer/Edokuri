import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/models/record.dart';
import 'package:mobx/mobx.dart';

part 'record_sort_controller.g.dart';

enum RecordsSortTypes { alphabetically }

String getSortTypeName(RecordsSortTypes type) {
  switch (type) {
    case RecordsSortTypes.alphabetically:
      return "Alphabetically";
  }
}

class RecordsSortController = RecordsSortControllerBase
    with _$RecordsSortController;

abstract class RecordsSortControllerBase with Store {
  final DBController db;

  @observable
  RecordsSortTypes sortType = RecordsSortTypes.alphabetically;

  RecordsSortControllerBase(this.db);

  @computed
  String get sortTypeName => getSortTypeName(sortType);

  @action
  void setSortType(RecordsSortTypes? type) {
    sortType = type ?? RecordsSortTypes.alphabetically;
  }

  List<Record> sort(List<Record> records) {
    switch (sortType) {
      case RecordsSortTypes.alphabetically:
        return records.toList()
          ..sort((b1, b2) => b1.original.compareTo(b2.original));

      default:
    }

    throw Exception("Index out of range");
  }
}
