// 📦 Package imports:
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';

Future loadLanguageMonel(
    OnDeviceTranslatorModelManager manager, String model) async {
  await manager.downloadModel(model, isWifiRequired: false);
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
