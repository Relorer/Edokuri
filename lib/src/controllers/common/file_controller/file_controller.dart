// 🐦 Flutter imports:
import 'dart:developer';

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
    try {
      var book = await compute(_epubService.readBook, file);
      if (book.words.isEmpty) {
        return _toastController.showDefaultTost("The book can't be empty");
      }
      _bookRepository.putBook(book);
      _toastController.showDefaultTost("Book is added");
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      _toastController
          .showDefaultTost("Something went wrong, maybe the file is corrupted");
    }
  }

  Future getBookFromUser() async {
    var files = await _filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      await addBookFile(file);
    }
  }
}
