import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:mobx/mobx.dart';

import 'services/epub_service.dart';
import 'services/file_picker_service.dart';

part 'file_controller.g.dart';

class FileController = FileControllerBase with _$FileController;

abstract class FileControllerBase with Store {
  final EpubService _epubService = EpubService();
  final FilePickerService _filePickerService = FilePickerService();

  final DBController dbController;

  FileControllerBase(this.dbController);

  @action
  Future getBookFromUser() async {
    var files = await _filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      var book = await _epubService.readBook(file);
      dbController.putBook(book);
    }
  }
}
