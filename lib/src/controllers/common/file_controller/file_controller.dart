import 'package:freader/src/controllers/common/file_controller/services/toast_service.dart';
import 'package:freader/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'services/epub_service.dart';
import 'services/file_picker_service.dart';

class FileController {
  final EpubService _epubService = EpubService();
  final FilePickerService _filePickerService = FilePickerService();
  final ToastService _toastService = ToastService();

  final BookRepository bookRepository;

  FileController(this.bookRepository);

  Future getBookFromUser() async {
    var files = await _filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      var book = await _epubService.readBook(file);
      if (book.words.isEmpty) {
        return _toastService.showDefaultTost("The book can't be empty");
      }
      bookRepository.putBook(book);
    }
  }
}
