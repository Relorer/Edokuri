import 'package:flutter/widgets.dart';
import 'package:freader/src/controllers/base_provider.dart';
import 'package:freader/src/controllers/translator_controller/translator_controller.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class ProviderTranslatorController extends BaseProvider<TranslatorController> {
  ProviderTranslatorController(
      {super.key, required super.child, required OnDeviceTranslator translator})
      : super(controller: TranslatorController(translator));

  const ProviderTranslatorController.setController(
      {super.key,
      required super.child,
      required TranslatorController controller})
      : super(controller: controller);

  static TranslatorController ctr(BuildContext context) =>
      BaseProvider.of<ProviderTranslatorController>(context).controller;
}
