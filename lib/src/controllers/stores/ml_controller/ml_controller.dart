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

  @action
  Future<void> loadMLState() async {
    isLoaded = await modelManager.isModelDownloaded(TranslateLanguage.english.bcpCode) &&
        await modelManager.isModelDownloaded(TranslateLanguage.russian.bcpCode);
  }

}
