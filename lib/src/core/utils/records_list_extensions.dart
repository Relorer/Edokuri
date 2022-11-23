import 'package:freader/src/models/record.dart';
import 'package:mobx/mobx.dart';

extension RecordsListExtensions on ObservableList<Record> {
  List<Record> get saved => where((element) => !element.known).toList();
}
