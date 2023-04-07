// 🎯 Dart imports:
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// 📦 Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/file_controller/services/file_picker_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/models.dart';

class DictionaryController {
  Future<String> createTempTxtFile(String text) async {
    final Directory directory = await getTemporaryDirectory();
    final File file = File('${directory.path}/dictionary.txt');
    await file.writeAsString(text);
    return file.path;
  }

  void shareDictionary() async {
    try {
      String dictionary = "";
      final records = getIt<RecordRepository>().records;
      for (var record in records) {
        dictionary += "${record.original}\t${record.translation}\n";
      }
      String path = await createTempTxtFile(dictionary);
      Share.shareXFiles([XFile(path)]);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  void importDictionary() async {
    try {
      final files =
          await FilePickerService().getFiles(allowedExtensions: ["txt"]);
      files.first
          .openRead()
          .map(utf8.decode)
          .transform(const LineSplitter())
          .forEach((line) async {
        String word = "";
        int i = 0;
        while (line[i] != '\t') {
          word += line[i];
          i++;
        }
        String translation = line.substring(i + 1);
        List<Translation> translations = List.empty(growable: true);
        translation.split(',').forEach((element) {
          translations.add(
              Translation(element.trim(), source: userSource, selected: true));
        });
        if (getIt<RecordRepository>().getRecord(word) == null) {
          Record record = await getIt<TranslatorController>().translate(word);
          for (var translation in translations) {
            record.translations.add(translation);
          }
          getIt<RecordRepository>().putRecord(record);
        }
      });
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
