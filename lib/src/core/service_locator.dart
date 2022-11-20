import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/db_controller/db_controller_factory.dart';
import 'package:freader/src/controllers/file_controller/file_controller.dart';
import 'package:freader/src/controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/reading_timer_controller/reading_timer_controller.dart';
import 'package:freader/src/controllers/translator_controller/translator_controller_factory.dart';
import 'package:freader/src/models/book.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerFactory(() => FileController(getIt<DBController>()));
  getIt.registerFactory(() => LibrarySortController(getIt<DBController>()));
  getIt.registerFactoryParam<ReaderController, Book, void>(
      (book, _) => ReaderController(getIt<DBController>(), book));
  getIt.registerFactoryParam<ReadingTimerController, Book, void>(
      (book, _) => ReadingTimerController(getIt<DBController>(), book));

  getIt.registerSingletonAsync(() => DBControllerFactory().getDBController());
  getIt.registerSingletonAsync(
      () => TranslatorControllerFactory().getTranslatorController());
}
