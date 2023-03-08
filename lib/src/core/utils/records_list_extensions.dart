// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:edokuri/src/models/models.dart';

extension RecordsObservableListExtensions on ObservableList<Record> {
  List<Record> get saved => where((element) => !element.known).toList();
}

extension RecordsListExtensions on List<Record> {
  List<Record> get saved => where((element) => !element.known).toList();
}
