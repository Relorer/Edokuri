// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/utils/datetime_extensions.dart';
import 'package:edokuri/src/models/models.dart';

part 'known_records_repository.g.dart';

class KnownRecordsRepository = KnownRecordsRepositoryBase
    with _$KnownRecordsRepository;

const _knownRecords = "knownRecords";

abstract class KnownRecordsRepositoryBase with Store {
  final PocketbaseController pb;

  ObservableList<KnownRecords> knownRecords =
      ObservableList<KnownRecords>.of([]);

  KnownRecordsRepositoryBase(this.pb) {
    pb.client.collection(_knownRecords).getFullList().then((value) {
      knownRecords.addAll(value.map((e) => KnownRecords.fromRecord(e)));
      pb.client.collection(_knownRecords).subscribe("*", (e) {
        try {
          if (e.record == null) return;
          final record = KnownRecords.fromRecord(e.record!);
          knownRecords.removeWhere((element) => element.id == record.id);
          if (e.action == "update" || e.action == "create") {
            knownRecords.add(record);
          }
        } catch (e, stacktrace) {
          log("${e.toString()}\n${stacktrace.toString()}");
        }
      });
    });
  }

  Future putKnownRecords(KnownRecords set) async {
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

  void dispose() async {
    try {
      await pb.client.collection(_knownRecords).unsubscribe("*");
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future removeAll() async {
    try {
      final copy = knownRecords.toList();
      for (var element in copy) {
        await removeSet(element);
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future removeSet(KnownRecords set) async {
    try {
      await pb.client.collection(_knownRecords).delete(set.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future addRecords(List<String> records) async {
    try {
      await putKnownRecords(
          KnownRecords(records: records, creationDate: DateTime.now().toUtc()));
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  bool exist(String record) {
    for (var records in knownRecords) {
      if (records.records.contains(record.toLowerCase())) return true;
    }
    return false;
  }

  int count() {
    if (knownRecords.isEmpty) return 0;
    return knownRecords.expand((element) => element.records).toSet().length;
  }

  int countForDay(DateTime day) {
    final batches =
        knownRecords.where((element) => element.creationDate.isSameDate(day));
    if (batches.isEmpty) return 0;

    return batches.expand((element) => element.records).toSet().length;
  }
}
