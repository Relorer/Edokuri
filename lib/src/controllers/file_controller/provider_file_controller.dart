import 'package:flutter/widgets.dart';
import 'package:freader/src/controllers/base_provider.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/file_controller/file_controller.dart';

class ProviderFileController extends BaseProvider<FileController> {
  final DBController dbController;

  ProviderFileController(
      {super.key, required super.child, required this.dbController})
      : super(controller: FileController(dbController));

  static FileController ctr(BuildContext context) =>
      BaseProvider.of<ProviderFileController>(context).controller;
}
