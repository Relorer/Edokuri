// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/models/models.dart';

part 'set_records_repository.g.dart';

class SetRecordsRepository = SetRecordsRepositoryBase
    with _$SetRecordsRepository;

const _setRecords = "setRecords";

abstract class SetRecordsRepositoryBase with Store {
  final PocketbaseController pb;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<SetRecords> sets = ObservableList<SetRecords>.of([]);

  SetRecordsRepositoryBase(this.pb) {
    isLoading = true;
    pb.client.collection(_setRecords).getFullList().then((value) {
      sets.addAll(value.map((e) => SetRecords.fromRecord(e)));
      isLoading = false;
      pb.client.collection(_setRecords).subscribe("*", (e) {
        try {
          if (e.record == null) return;
          final record = SetRecords.fromRecord(e.record!);
          sets.removeWhere((element) => element.id == record.id);
          if (e.action == "update" || e.action == "create") {
            sets.add(record);
          }
        } catch (e, stacktrace) {
          log("${e.toString()}\n${stacktrace.toString()}");
        }
      });
    });
  }

  void putSet(SetRecords set) async {
    try {
      final body = set.toJson()..["user"] = pb.user?.id;
      if (set.id.isEmpty) {
        await pb.client.collection(_setRecords).create(body: body);
      } else {
        await pb.client.collection(_setRecords).update(set.id, body: body);
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  void removeSet(SetRecords set) async {
    try {
      await pb.client.collection(_setRecords).delete(set.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
