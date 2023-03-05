import 'package:freader/src/controllers/stores/appwrite/appwrite_controller.dart';
import 'package:freader/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:freader/src/controllers/stores/appwrite/repositories/book_repository/book_repository.dart'
    as aw;
import 'package:freader/src/core/service_locator.dart';

import 'services/epub_service.dart';
import 'services/file_picker_service.dart';

class FileController {
  final EpubService _epubService = EpubService();
  final FilePickerService _filePickerService = FilePickerService();

  final BookRepository bookRepository;

  FileController(this.bookRepository);

  Future getBookFromUser() async {
    var files = await _filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      var book = await _epubService.readBook(file);
      //bookRepository.putBook(book);
      aw.BookRepository(getIt<AppwriteController>()).putBook(book);
    }
  }
}
