// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'services/epub_service.dart';
import 'services/file_picker_service.dart';

class FileController {
  final EpubService _epubService = EpubService();
  final FilePickerService _filePickerService = FilePickerService();
  final ToastController _toastController;
  final BookRepository _bookRepository;

  FileController(this._bookRepository, this._toastController);

  Future addBookFile(Uint8List file) async {
    var book = await compute(_epubService.readBook, file);
    if (book.words.isEmpty) {
      return _toastController.showDefaultTost("The book can't be empty");
    }
    if (_bookRepository.books
        .where((element) => element.hash == book.hash)
        .isNotEmpty) {
      return _toastController
          .showDefaultTost("The book has already been added");
    }
    _bookRepository.putBook(book);
    _toastController.showDefaultTost("Book is added");
  }

  Future getBookFromUser() async {
    var files = await _filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      await addBookFile(file);
    }
  }
}
