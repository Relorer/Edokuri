// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/utils/datetime_extensions.dart';
import 'package:edokuri/src/models/models.dart';

part 'time_mark_repository.g.dart';

class TimeMarkRepository = TimeMarkRepositoryBase with _$TimeMarkRepository;

const _timeMark = "timeMark";

abstract class TimeMarkRepositoryBase with Store {
  final PocketbaseController pb;

  ObservableList<TimeMark> timeMarks = ObservableList<TimeMark>.of([]);

  TimeMarkRepositoryBase(this.pb) {
    pb.client.collection(_timeMark).getFullList().then((value) {
      timeMarks.addAll(value.map((e) => TimeMark.fromRecord(e)));
      pb.client.collection(_timeMark).subscribe("*", (e) {
        try {
          if (e.record == null) return;
          final record = TimeMark.fromRecord(e.record!);
          timeMarks.removeWhere((element) => element.id == record.id);
          if (e.action == "update" || e.action == "create") {
            timeMarks.add(record);
          }
        } catch (e, stacktrace) {
          log("${e.toString()}\n${stacktrace.toString()}");
        }
      });
    });
  }

  void putTimeMark(TimeMark mark) async {
    try {
      final body = mark.toJson()..["user"] = pb.user?.id;
      if (mark.id.isEmpty) {
        await pb.client.collection(_timeMark).create(body: body);
      } else {
        await pb.client.collection(_timeMark).update(mark.id, body: body);
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  void removeTimeMark(TimeMark mark) async {
    try {
      await pb.client.collection(_timeMark).delete(mark.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  void addTimeMarkForToday() {
    DateTime now = DateTime.now().toUtc();

    timeMarks.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    if (timeMarks.isEmpty || !timeMarks.last.dateTime.isSameDate(now)) {
      putTimeMark(TimeMark(dateTime: now));
    }
  }

  int getStreak() {
    if (timeMarks.isEmpty) return 0;

    timeMarks.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    DateTime date = DateTime.now().toUtc();
    int result = timeMarks.last.dateTime.isSameDate(date) ? 1 : 0;

    for (var element in timeMarks.reversed.skip(1)) {
      if (element.dateTime.isSameDate(date)) {
        result++;
      } else {
        break;
      }
      date.subtract(const Duration(days: 1));
    }

    return result;
  }
}
