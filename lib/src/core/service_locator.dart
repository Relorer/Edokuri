import 'package:freader/objectbox.g.dart';
import 'package:freader/src/controllers/common/file_controller/file_controller.dart';
import 'package:freader/src/controllers/common/reading_timer_controller/reading_timer_controller.dart';
import 'package:freader/src/controllers/common/translator_controller/translator_controller_factory.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:freader/src/controllers/stores/repositories/set_repository/set_repository.dart';
import 'package:freader/src/controllers/stores/repositories/store_factory.dart';
import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/controllers/stores/set_controller/set_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerFactory(() => FileController(getIt<BookRepository>()));
  getIt.registerFactory(() => TTSController());
  getIt.registerFactory(() => LibrarySortController(getIt<RecordRepository>()));
  getIt.registerFactory(() => RecordsSortController(getIt<RecordRepository>()));
  getIt.registerFactoryParam<ReaderController, Book, void>((book, _) =>
      ReaderController(
          getIt<RecordRepository>(), getIt<BookRepository>(), book));
  getIt.registerFactoryParam<ReadingTimerController, Book, void>(
      (book, _) => ReadingTimerController(getIt<BookRepository>(), book));

  getIt.registerSingletonAsync(
      () => TranslatorControllerFactory().getTranslatorController());

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
