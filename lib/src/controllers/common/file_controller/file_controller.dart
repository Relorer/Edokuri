import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';

import 'services/epub_service.dart';
import 'services/file_picker_service.dart';

class FileController {
  final EpubService _epubService = EpubService();
  final FilePickerService _filePickerService = FilePickerService();

  final DBController dbController;

  FileController(this.dbController);

  Future getBookFromUser() async {
    var files = await _filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      var book = await _epubService.readBook(file);
      dbController.putBook(book);
    }
  }
}
