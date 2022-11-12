import 'package:flutter/widgets.dart';
import 'package:freader/src/controllers/base_provider.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';

class ProviderReaderController extends BaseProvider<ReaderController> {
  ProviderReaderController({super.key, required super.child})
      : super(controller: ReaderController());

  const ProviderReaderController.setController(
      {super.key, required super.child, required ReaderController controller})
      : super(controller: controller);

  static ReaderController ctr(BuildContext context) =>
      BaseProvider.of<ProviderReaderController>(context).controller;
}
