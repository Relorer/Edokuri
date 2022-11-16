import 'package:freader/src/controllers/translator_controller/translator_controller.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslatorControllerFactory {
  loadLanguageMonel(
      OnDeviceTranslatorModelManager manager, String model) async {
    if (!await manager.isModelDownloaded(model)) {
      await manager.downloadModel(model);
    }
  }

  Future<TranslatorController> getTranslatorController() async {
    final modelManager = OnDeviceTranslatorModelManager();

    await loadLanguageMonel(modelManager, TranslateLanguage.english.bcpCode);
    await loadLanguageMonel(modelManager, TranslateLanguage.russian.bcpCode);

    final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: TranslateLanguage.russian);

    return TranslatorController(translator);
  }
}
