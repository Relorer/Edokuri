// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/file_controller/file_controller.dart';
import 'package:edokuri/src/controllers/common/handle_volume_button/handle_volume_button.dart';
import 'package:edokuri/src/controllers/common/learning_timer_controller/learning_timer_controller.dart';
import 'package:edokuri/src/controllers/common/reading_timer_controller/reading_timer_controller.dart';
import 'package:edokuri/src/controllers/common/snackbar_controller/snackbar_controller.dart';
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller_factory.dart';
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:edokuri/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_factory.dart';
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:edokuri/src/models/models.dart';

final getIt = GetIt.instance;

Future setupLocator() async {
  getIt.registerSingletonAsync(() => TTSControllerFactory().getTTSController());
  getIt.registerFactory(() => ToastController());
  getIt.registerFactory(() => SnackbarController());
  getIt.registerFactoryParam<LearnController, List<Record>, void>(
      (records, _) => LearnController(
          getIt<RecordRepository>(), getIt<SettingsController>(), records));

  getIt.registerSingleton(MLController());
  getIt.registerSingleton<HandleVolumeController>(HandleVolumeController(),
      dispose: (param) {
    param.dispose();
  });

  getIt.registerSingletonAsync(
      () => TranslatorControllerFactory().getTranslatorController());

  getIt.registerSingletonAsync<SettingsController>(
      () => SettingsControllerFactory().getSettingsController());

  getIt.registerSingleton(const FlutterSecureStorage());

  getIt.registerSingletonAsync<PocketbaseController>(PocketBaseFactory().getPB);
}

Future setupRepositoryScope(String userId) async {
  if (getIt.currentScopeName == userId) return;
  if (getIt.currentScopeName != "baseScope") {
    await getIt.popScope();
  }

  getIt.pushNewScope(
      init: (getIt) {
        getIt.registerSingletonWithDependencies(
            () => BookRepository(getIt<PocketbaseController>()),
            dependsOn: [PocketbaseController]);
        getIt.registerSingletonWithDependencies(
            () => ActivityTimeRepository(getIt<PocketbaseController>()),
            dependsOn: [PocketbaseController]);
        getIt.registerSingletonWithDependencies(
            () => TimeMarkRepository(getIt<PocketbaseController>()),
            dependsOn: [PocketbaseController]);
        getIt.registerSingletonWithDependencies(
            () => SetRecordsRepository(getIt<PocketbaseController>()),
            dependsOn: [PocketbaseController]);
        getIt.registerSingletonWithDependencies(
            () => KnownRecordsRepository(getIt<PocketbaseController>()),
            dependsOn: [PocketbaseController]);
        getIt.registerSingletonWithDependencies(
            () => RecordRepository(getIt<PocketbaseController>(),
                getIt<SetRecordsRepository>(), getIt<KnownRecordsRepository>()),
            dependsOn: [PocketbaseController]);

        getIt.registerSingletonWithDependencies(
            () => LibrarySortController(getIt<RecordRepository>()),
            dependsOn: [RecordRepository]);
        getIt.registerSingletonWithDependencies(
            () => RecordsSortController(getIt<RecordRepository>()),
            dependsOn: [RecordRepository]);

        getIt.registerFactory(() =>
            FileController(getIt<BookRepository>(), getIt<ToastController>()));

        getIt.registerFactoryParam<ReaderController, Book, void>((book, _) =>
            ReaderController(
                getIt<RecordRepository>(),
                getIt<BookRepository>(),
                getIt<KnownRecordsRepository>(),
                getIt<HandleVolumeController>(),
                book));

        getIt.registerSingletonWithDependencies<ReadingTimerController>(
            () => ReadingTimerController(getIt<BookRepository>(),
                getIt<ActivityTimeRepository>(), getIt<TimeMarkRepository>()),
            dependsOn: [
              BookRepository,
              ActivityTimeRepository,
              TimeMarkRepository
            ]);

        getIt.registerSingletonWithDependencies<LearningTimerController>(
            () => LearningTimerController(
                getIt<ActivityTimeRepository>(), getIt<TimeMarkRepository>()),
            dependsOn: [ActivityTimeRepository, TimeMarkRepository]);
      },
      scopeName: userId);
}
