// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/services/yandex_translator_service.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';

Future loadLanguageModel(
    OnDeviceTranslatorModelManager manager, String model) async {
  await manager.downloadModel(model, isWifiRequired: false);
}

class TranslatorControllerFactory {
  Future<TranslatorController> getTranslatorController() async {
    final modelManager = OnDeviceTranslatorModelManager();

    loadLanguageModel(modelManager, TranslateLanguage.english.bcpCode);
    loadLanguageModel(modelManager, TranslateLanguage.russian.bcpCode);

    final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: TranslateLanguage.russian);

    final secureStorage = getIt<FlutterSecureStorage>();
    final yaKey = await secureStorage.read(key: YandexTranslatorServiceKey);
    return TranslatorController(
        translator, YandexTranslatorService(yaKey ?? ""));
  }
}
