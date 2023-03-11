import 'package:freader/objectbox.g.dart';
import 'package:freader/src/controllers/common/file_controller/file_controller.dart';
import 'package:freader/src/controllers/common/learning_timer_controller/learning_timer_controller.dart';
import 'package:freader/src/controllers/common/reading_timer_controller/reading_timer_controller.dart';
import 'package:freader/src/controllers/common/settings_controller/settings_controller.dart';
import 'package:freader/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:freader/src/controllers/common/translator_controller/translator_controller_factory.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:freader/src/controllers/stores/repositories/set_repository/set_repository.dart';
import 'package:freader/src/controllers/stores/repositories/store_factory.dart';
import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:get_it/get_it.dart';

import '../controllers/stores/ml_controller/ml_controller.dart';
import '../models/models.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerFactory(() => FileController(getIt<BookRepository>(), getIt<ToastController>()));
  getIt.registerFactory(() => TTSController());
  getIt.registerFactory(() => LibrarySortController(getIt<RecordRepository>()));
  getIt.registerFactory(() => RecordsSortController(getIt<RecordRepository>()));
  getIt.registerFactory(() => ToastController());
  getIt.registerFactoryParam<ReaderController, Book, void>((book, _) =>
      ReaderController(
          getIt<RecordRepository>(), getIt<BookRepository>(), book));

  getIt.registerFactoryParam<LearnController, List<Record>, void>(
      (records, _) => LearnController(
          getIt<RecordRepository>(), getIt<SettingsController>(), records));

  getIt.registerFactoryParam<ReadingTimerController, Book, void>((book, _) =>
      ReadingTimerController(
          getIt<BookRepository>(), getIt<UserRepository>(), book));

  getIt.registerFactory<LearningTimerController>(
      () => LearningTimerController(getIt<UserRepository>()));

  getIt.registerSingletonAsync(
      () => TranslatorControllerFactory().getTranslatorController());

  getIt.registerSingletonAsync<SettingsController>(
      () => SrttingsControllerFactory().getSettingsController());

  getIt.registerSingleton(MLController());

  //repositories
  getIt.registerSingletonAsync<Store>(() => StoreFactory().getDBController());
  getIt.registerSingletonWithDependencies(() => UserRepository(getIt<Store>()),
      dependsOn: [Store]);
  getIt.registerSingletonWithDependencies(
      () => BookRepository(getIt<Store>(), getIt<UserRepository>()),
      dependsOn: [Store]);
  getIt.registerSingletonWithDependencies(
      () => SetRepository(getIt<Store>(), getIt<UserRepository>()),
      dependsOn: [Store]);
  getIt.registerSingletonWithDependencies(
      () => RecordRepository(getIt<Store>(), getIt<UserRepository>()),
      dependsOn: [Store]);
}
