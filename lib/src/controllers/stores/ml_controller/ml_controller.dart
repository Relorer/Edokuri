// 📦 Package imports:
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:mobx/mobx.dart';

part 'ml_controller.g.dart';

class MLController = MLControllerBase with _$MLController;

abstract class MLControllerBase with Store {
  MLControllerBase() {
    loadMLState();
  }

  final modelManager = OnDeviceTranslatorModelManager();

  @observable
  bool isLoaded = false;

  @observable
  bool isLoading = false;

  @action
  Future loadMLState() async {
    isLoaded = await modelManager
            .isModelDownloaded(TranslateLanguage.english.bcpCode) &&
        await modelManager.isModelDownloaded(TranslateLanguage.russian.bcpCode);
  }

  @action
  Future downloadModels() async {
    isLoading = true;
    await modelManager.downloadModel(
        isWifiRequired: false, TranslateLanguage.english.bcpCode);
    await modelManager.downloadModel(
        isWifiRequired: false, TranslateLanguage.russian.bcpCode);
    isLoading = false;
    loadMLState();
  }
}
