// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
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

    final filtered = records
        .where((element) => element.originalLowerCase.contains(_request))
        .toList();
    filtered.sort((r1, r2) =>
        r1.originalLowerCase.indexOf(_request) -
        r2.originalLowerCase.indexOf(_request));
    return filtered;
  }
}
