import 'package:freader/src/controllers/common/cache_controller/cache_controller.dart';
import 'package:freader/src/controllers/common/file_controller/file_controller.dart';
import 'package:freader/src/controllers/common/learning_timer_controller/learning_timer_controller.dart';
import 'package:freader/src/controllers/common/reading_timer_controller/reading_timer_controller.dart';
import 'package:freader/src/controllers/common/settings_controller/settings_controller.dart';
import 'package:freader/src/controllers/common/translator_controller/translator_controller_factory.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/controllers/stores/appwrite/appwrite_controller.dart';
import 'package:freader/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:freader/src/controllers/stores/repositories/set_repository/set_repository.dart';
import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:get_it/get_it.dart';

import '../models/models.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerFactory(() => FileController(getIt<BookRepository>()));
  getIt.registerFactory(() => TTSController());
  getIt.registerFactory(() => LibrarySortController(getIt<RecordRepository>()));
  getIt.registerFactory(() => RecordsSortController(getIt<RecordRepository>()));
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

  //repositories

  getIt.registerSingleton<CacheController>(CacheController());
  getIt.registerSingleton<AppwriteController>(AppwriteController());

  getIt.registerSingleton(UserRepository(getIt<AppwriteController>()));
  getIt.registerSingleton(BookRepository(getIt<AppwriteController>(),
      getIt<UserRepository>(), getIt<CacheController>()));
  getIt.registerSingleton(
      SetRepository(getIt<AppwriteController>(), getIt<UserRepository>()));
  getIt.registerSingleton(
      RecordRepository(getIt<AppwriteController>(), getIt<UserRepository>()));
}
