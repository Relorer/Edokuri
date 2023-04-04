// 🎯 Dart imports:
import 'dart:async';
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/models.dart';
import 'services/epub_service.dart';
import 'services/file_picker_service.dart';

// 📦 Package imports:

class BookWithStatus {
  final Book? book;
  final bool isAdded;
  final bool isExist;

  BookWithStatus(this.book, this.isAdded, this.isExist);
}

class FileController {
  final EpubService _epubService = EpubService();
  final FilePickerService _filePickerService = FilePickerService();
  final ToastController _toastController;
  final BookRepository _bookRepository;

  FileController(this._bookRepository, this._toastController);

  Future<BookWithStatus> addBookFile(FutureOr<List<int>> file) async {
    try {
      var book = await compute(_epubService.readBook, await file);

      if (book.words.isEmpty) {
        _toastController.showDefaultTost("The book can't be empty");
        return BookWithStatus(null, false, false);
      }
      final pocketbase = await getIt.getAsync<PocketbaseController>();
      book.hash =
          "${pocketbase.user!.id}-${pocketbase.user!.name}-${book.hash}";

      final existed =
          _bookRepository.books.where((element) => element.hash == book.hash);

      if (existed.isNotEmpty) {
        _toastController.showDefaultTost("The book has already been added");
        return BookWithStatus(existed.first, false, true);
      }

      _bookRepository.putBook(book);
      _toastController
          .showDefaultTost("Book is added. Please wait for it to load");
      return BookWithStatus(book, true, false);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      _toastController
          .showDefaultTost("Something went wrong, maybe the file is corrupted");
      return BookWithStatus(null, false, false);
    }
  }

  Future getBookFromUser() async {
    var files = await _filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      await addBookFile(file);
    }
  }
}
