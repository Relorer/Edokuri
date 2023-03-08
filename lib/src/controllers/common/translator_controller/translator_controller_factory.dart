// 📦 Package imports:
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';

class TranslatorControllerFactory {
  loadLanguageMonel(
      OnDeviceTranslatorModelManager manager, String model) async {
    if (!await manager.isModelDownloaded(model)) {
      await manager.downloadModel(model, isWifiRequired: false);
    }
  }

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
