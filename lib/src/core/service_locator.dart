import 'package:freader/src/controllers/common/file_controller/file_controller.dart';
import 'package:freader/src/controllers/common/reading_timer_controller/reading_timer_controller.dart';
import 'package:freader/src/controllers/common/translator_controller/translator_controller_factory.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller_factory.dart';
import 'package:freader/src/controllers/stores/set_controller/set_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/set.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerFactory(() => FileController(getIt<DBController>()));
  getIt.registerFactory(() => TTSController());
  getIt.registerFactory(() => LibrarySortController(getIt<DBController>()));
  getIt.registerFactory(() => RecordsSortController(getIt<DBController>()));
  getIt.registerFactoryParam<ReaderController, Book, void>(
      (book, _) => ReaderController(getIt<DBController>(), book));
  getIt.registerFactoryParam<ReadingTimerController, Book, void>(
      (book, _) => ReadingTimerController(getIt<DBController>(), book));

  getIt.registerFactoryParam<SetController, List<Record>, SetRecords?>(
      (records, set) =>
          SetController(getIt<DBController>(), records, set: set));

  getIt.registerSingletonAsync(() => DBControllerFactory().getDBController());
  getIt.registerSingletonAsync(
      () => TranslatorControllerFactory().getTranslatorController());
}
