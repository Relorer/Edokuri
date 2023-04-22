// 🎯 Dart imports:
import 'dart:math';

// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/utils/iterable_extensions.dart';
import 'package:edokuri/src/models/models.dart';

part 'search_record_controller.g.dart';

class SearchRecordController = SearchRecordControllerBase
    with _$SearchRecordController;

abstract class SearchRecordControllerBase with Store {
  @observable
  String _request = "";

  @action
  void setNewRequest(String request) {
    _request = request.trim().toLowerCase();
  }

  List<Record> getSearchResult(List<Record> records) {
    if (_request.isEmpty) return records;

    if (RegExp(r'[a-z]').hasMatch(_request)) {
      final filtered = records
          .where((element) => element.originalLowerCase.contains(_request))
          .toList();
      filtered.sort((r1, r2) =>
          r1.originalLowerCase.indexOf(_request) -
          r2.originalLowerCase.indexOf(_request));
      return filtered;
    } else {
      final filtered = records
          .where((element) =>
              element.translations.firstWhereOrNull(
                  (p0) => p0.text.toLowerCase().contains(_request)) !=
              null)
          .toList();
      filtered.sort((r1, r2) {
        final selected1 = r1.translations.where(
            (element) => element.selected && element.text.contains(_request));
        final selected2 = r2.translations.where(
            (element) => element.selected && element.text.contains(_request));
        if (selected1.length != selected2.length) {
          return selected2.length - selected1.length;
        }

        if (selected1.isNotEmpty) {
          return selected1.map((e) => e.text.indexOf(_request)).reduce(min) -
              selected2.map((e) => e.text.indexOf(_request)).reduce(min);
        }

        final max = double.maxFinite.toInt();
        return r1.translations.map((e) {
              final index = e.text.indexOf(_request);
              return index == -1 ? max : index;
            }).reduce(min) -
            r2.translations.map((e) {
              final index = e.text.indexOf(_request);
              return index == -1 ? max : index;
            }).reduce(min);
      });
      return filtered;
    }
  }
}
