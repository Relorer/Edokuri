import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<List<Uint8List>> getFiles({List<String>? allowedExtensions}) async {
    var filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    List<Uint8List> result = [];

    for (var file in filePickerResult?.files ?? []) {
      if (file.path == null) continue;
      result.add(await File(file.path!).readAsBytes());
    }

    return result;
  }
}
