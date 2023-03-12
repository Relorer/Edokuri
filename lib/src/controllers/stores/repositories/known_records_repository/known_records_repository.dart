// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/models/models.dart';

part 'known_records_repository.g.dart';

class KnownRecordsRepository = KnownRecordsRepositoryBase
    with _$KnownRecordsRepository;

const _knownRecords = "knownRecords";

abstract class KnownRecordsRepositoryBase with Store {
  final PocketbaseController pb;

  ObservableList<KnownRecords> sets = ObservableList<KnownRecords>.of([]);

  KnownRecordsRepositoryBase(this.pb) {
    pb.client.collection(_knownRecords).getFullList().then((value) {
      sets.addAll(value.map((e) => KnownRecords.fromRecord(e)));
      pb.client.collection(_knownRecords).subscribe("*", (e) {
        try {
          if (e.record == null) return;
          final record = KnownRecords.fromRecord(e.record!);
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

  void putSet(KnownRecords set) async {
    try {
      final body = set.toJson()..["user"] = pb.user?.id;
      if (set.id.isEmpty) {
        await pb.client.collection(_knownRecords).create(body: body);
      } else {
        await pb.client.collection(_knownRecords).update(set.id, body: body);
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  void removeSet(KnownRecords set) async {
    try {
      await pb.client.collection(_knownRecords).delete(set.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
