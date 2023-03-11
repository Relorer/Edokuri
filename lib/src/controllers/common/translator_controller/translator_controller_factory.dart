import 'package:freader/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

Future loadLanguageMonel(
    OnDeviceTranslatorModelManager manager, String model) async {
  if (!await manager.isModelDownloaded(model)) {
    await manager.downloadModel(model, isWifiRequired: false);
  }
}

class TranslatorControllerFactory {
  Future<TranslatorController> getTranslatorController() async {
    final modelManager = OnDeviceTranslatorModelManager();

    loadLanguageMonel(modelManager, TranslateLanguage.english.bcpCode);
    loadLanguageMonel(modelManager, TranslateLanguage.russian.bcpCode);

    final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: TranslateLanguage.russian);

    return TranslatorController(translator);
  }
}
