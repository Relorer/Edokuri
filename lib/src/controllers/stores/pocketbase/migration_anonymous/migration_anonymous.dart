// 🎯 Dart imports:
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/cache_controller/cache_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/alert_dialog.dart';
import 'package:edokuri/src/models/models.dart';

class MigrationAnonymous with Store {
  final secureStorage = getIt<FlutterSecureStorage>();
  final pocketbase = getIt<PocketbaseController>();
  final CacheController cacheController = CacheController();
  final client = PocketBase(pocketbaseUrl);

  Future load(BuildContext context) async {
    try {
      if (pocketbase.user?.email == null || pocketbase.user?.email == "") {
        // We are anonymous
        return;
      }
      final username = await secureStorage.read(key: usernameKey);
      final password = await secureStorage.read(key: passwordKey);

      if (username != null && password != null) {
        final recordAuth = await client
            .collection('users')
            .authWithPassword(username, password);
        if (recordAuth.record == null) {
          return;
        }
        final user = User.fromRecord(recordAuth.record!);
        if (context.mounted) {
          final result = await showOkCancelAlertDialogStyled(
              context: context,
              title: "Migration",
              message:
                  "Do you want to transfer your data from \"${user.name}\" to your current account?");
          if (result == OkCancelResult.ok) {
            final books = await client.collection("book").getFullList();
            final records = await client.collection("record").getFullList();
            final activityTimes =
                await client.collection("activityTime").getFullList();
            final knownRecords =
                await client.collection("knownRecords").getFullList();
            final sets = await client.collection("setRecords").getFullList();
            final timeMarks = await client.collection("timeMark").getFullList();

            for (final book in books) {
              await client.collection("book").update(book.id, body: {
                "user": pocketbase.user!.id,
              });
            }

            for (final record in records) {
              await client.collection("record").update(record.id, body: {
                "user": pocketbase.user!.id,
              });
            }

            for (final activityTime in activityTimes) {
              await client
                  .collection("activityTime")
                  .update(activityTime.id, body: {
                "user": pocketbase.user!.id,
              });
            }

            for (final knownRecord in knownRecords) {
              await client
                  .collection("knownRecords")
                  .update(knownRecord.id, body: {
                "user": pocketbase.user!.id,
              });
            }

            for (final set in sets) {
              await client.collection("setRecords").update(set.id, body: {
                "user": pocketbase.user!.id,
              });
            }

            for (final timeMark in timeMarks) {
              await client.collection("timeMark").update(timeMark.id, body: {
                "user": pocketbase.user!.id,
              });
            }

            await client.collection("users").delete(user.id);
            await secureStorage.delete(key: usernameKey);
            await secureStorage.delete(key: passwordKey);

            await setupRepositoryScope("");
            await setupRepositoryScope(pocketbase.user!.id);
          } else {
            await client.collection("users").delete(user.id);
            await secureStorage.delete(key: usernameKey);
            await secureStorage.delete(key: passwordKey);
          }
        }
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  @action
  Future logout() async {
    secureStorage.deleteAll();
    client.authStore.clear();
  }
}
