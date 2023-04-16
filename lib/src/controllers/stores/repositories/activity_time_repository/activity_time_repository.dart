// 🎯 Dart imports:
import 'dart:developer';

// 📦 Package imports:
import 'package:mobx/mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/date_controller/date_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/datetime_extensions.dart';
import 'package:edokuri/src/models/models.dart';

part 'activity_time_repository.g.dart';

class ActivityTimeRepository = ActivityTimeRepositoryBase
    with _$ActivityTimeRepository;

const _activityTime = "activityTime";

abstract class ActivityTimeRepositoryBase with Store {
  final PocketbaseController pb;
  final DateController dateController = getIt<DateController>();

  ObservableList<ActivityTime> activityTimes =
      ObservableList<ActivityTime>.of([]);

  ActivityTimeRepositoryBase(this.pb) {
    pb.client.collection(_activityTime).getFullList().then((value) {
      activityTimes.addAll(value.map((e) => ActivityTime.fromRecord(e)));
      pb.client.collection(_activityTime).subscribe("*", (e) {
        try {
          if (e.record == null) return;
          final record = ActivityTime.fromRecord(e.record!);
          activityTimes.removeWhere((element) => element.id == record.id);
          if (e.action == "update" || e.action == "create") {
            activityTimes.add(record);
          }
        } catch (e, stacktrace) {
          log("${e.toString()}\n${stacktrace.toString()}");
        }
      });
    });
  }

  void dispose() async {
    try {
      await pb.client.collection(_activityTime).unsubscribe("*");
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future<ActivityTime?> putActivityTime(ActivityTime mark) async {
    try {
      final body = mark.toJson()..["user"] = pb.user?.id;
      if (mark.id.isEmpty) {
        return ActivityTime.fromRecord(
            await pb.client.collection(_activityTime).create(body: body));
      } else {
        return ActivityTime.fromRecord(await pb.client
            .collection(_activityTime)
            .update(mark.id, body: body));
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
    return null;
  }

  void removeActivityTime(ActivityTime mark) async {
    try {
      await pb.client.collection(_activityTime).delete(mark.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  int learningTimeForTodayInMinutes() {
    return _timeForTodayInMinutes(Type.learning);
  }

  int readingTimeForTodayInMinutes() {
    return _timeForTodayInMinutes(Type.reading);
  }

  int _timeForTodayInMinutes(Type type) {
    final today = dateController.now();
    final timesForToday = activityTimes
        .where((element) => element.type == type)
        .where((element) => element.created.isSameDate(today))
        .map((e) => e.timeSpan);

    final learningTimeForToday =
        timesForToday.isEmpty ? 0 : timesForToday.reduce((t1, t2) => t1 + t2);

    return learningTimeForToday / 1000 ~/ 60;
  }

  int learningTimeInMinutes() {
    return _timeInMinutes(Type.learning);
  }

  int readingTimeInMinutes() {
    return _timeInMinutes(Type.reading);
  }

  int _timeInMinutes(Type type) {
    final times = activityTimes
        .where((element) => element.type == type)
        .map((e) => e.timeSpan);

    final learningTimeForToday =
        times.isEmpty ? 0 : times.reduce((t1, t2) => t1 + t2);

    return learningTimeForToday / 1000 ~/ 60;
  }
}
