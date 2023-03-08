// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:edokuri/src/controllers/common/file_controller/file_controller.dart';
import 'package:edokuri/src/controllers/common/learning_timer_controller/learning_timer_controller.dart';
import 'package:edokuri/src/controllers/common/reading_timer_controller/reading_timer_controller.dart';
import 'package:edokuri/src/controllers/common/settings_controller/settings_controller.dart';
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller_factory.dart';
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_factory.dart';
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/set_repository/set_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import '../models/models.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerFactory(
      () => FileController(getIt<BookRepository>(), getIt<ToastController>()));
  getIt.registerFactory(() => TTSController());
  getIt.registerFactory(() => LibrarySortController(getIt<RecordRepository>()));
  getIt.registerFactory(() => RecordsSortController(getIt<RecordRepository>()));
  getIt.registerFactory(() => ToastController());
  getIt.registerFactoryParam<ReaderController, Book, void>((book, _) =>
      ReaderController(
          getIt<RecordRepository>(), getIt<BookRepository>(), book));

  getIt.registerFactoryParam<ReadingTimerController, Book, void>((book, _) =>
      ReadingTimerController(
          getIt<BookRepository>(), getIt<UserRepository>(), book));

  getIt.registerFactory<LearningTimerController>(
      () => LearningTimerController(getIt<UserRepository>()));

  getIt.registerSingletonAsync(
      () => TranslatorControllerFactory().getTranslatorController());

  getIt.registerSingletonAsync<SettingsController>(
      () => SettingsControllerFactory().getSettingsController());

  getIt.registerSingleton(const FlutterSecureStorage());

  getIt.registerSingletonAsync<PocketbaseController>(PocketBaseFactory().getPB);

  //repositories
  getIt.registerSingletonWithDependencies(
      () => UserRepository(getIt<PocketbaseController>()),
      dependsOn: [PocketbaseController]);
  getIt.registerSingletonWithDependencies(
      () => BookRepository(
          getIt<PocketbaseController>(), getIt<UserRepository>()),
      dependsOn: [PocketbaseController]);
  getIt.registerSingletonWithDependencies(
      () =>
          SetRepository(getIt<PocketbaseController>(), getIt<UserRepository>()),
      dependsOn: [PocketbaseController]);
  getIt.registerSingletonWithDependencies(
      () => RecordRepository(
          getIt<PocketbaseController>(), getIt<UserRepository>()),
      dependsOn: [PocketbaseController]);
}
