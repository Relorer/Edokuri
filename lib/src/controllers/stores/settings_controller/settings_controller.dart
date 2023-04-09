// 🎯 Dart imports:

// 📦 Package imports:
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/core/service_locator.dart';

// 🌎 Project imports:

part 'settings_controller.g.dart';

const _packSize = "PACKSIZE";
const _autoPronouncingInLearnPage = "AUTOPRONOUNCINGINLEARNPAGE";
const _frontCardInLearnPageTerm = "FRONTCARDINLEARNPAGE_TERM";
const _frontCardInLearnPageDefinition = "FRONTCARDINLEARNPAGE_DEFINITION";
const _isFirstOpening = "ISFIRSTOPENING";
const _einkMode = "EINKMODE";
const _safeArea = "SAFEAREA";
const _useYandexTranslator = "USEYATRANSLATORFORSENTENCE";
const _useDeeplTranslator = "USEDEEPLTRANSLATORFORSENTENCE";
const _useGoogleTranslator = "USEGOOGLETRANSLATORFORSENTENCE";
const _translatorOrderIndexes = "TRANSLATORORDERINDEXES";
const _learningAutoPronouncing = "LEARNINGAUTOPRONOUNCING";
const _ttsMaxRate = "TTSMAXRATE";
const _ttsMinRate = "TTSMINRATE";

class SettingsControllerFactory {
  Future<SettingsController> getSettingsController() async {
    return SettingsController(await SharedPreferences.getInstance());
  }
}

class SettingsController = SettingsControllerBase with _$SettingsController;

abstract class SettingsControllerBase with Store {
  final SharedPreferences _sp;

  @observable
  int packSize = 10;
  @observable
  bool autoPronouncingInLearnPage = true;
  @observable
  bool frontCardInLearnPageTerm = true;
  @observable
  bool frontCardInLearnPageDefinition = true;
  @observable
  bool isFirstOpening = true;
  @observable
  bool einkMode = false;
  @observable
  bool safeArea = true;
  @observable
  bool useYandexTranslator = false;
  @observable
  bool useDeeplTranslator = true;
  @observable
  bool useGoogleTranslator = true;
  @observable
  bool learningAutoPronouncing = true;
  @observable
  double ttsMaxRate = 0.3;
  @observable
  double ttsMinRate = 0.15;

  var translators = [
    deeplSource,
    yandexSource,
    googleSource,
    googleMlSource,
  ];

  @computed
  List<String> get translatorOrder {
    final result = <String>[];

    for (final index in translatorOrderIndexes) {
      final translator = translators[index];
      if (getStateByTranslator(translator)) {
        result.add(translator);
      }
    }
    return result;
  }

  bool getStateByTranslator(String translator) {
    switch (translator) {
      case deeplSource:
        return useDeeplTranslator;
      case yandexSource:
        return useYandexTranslator;
      case googleSource:
        return useGoogleTranslator;
      case googleMlSource:
        return true;
      default:
        return false;
    }
  }

  @observable
  List<int> translatorOrderIndexes = [0, 1, 2, 3];

  SettingsControllerBase(this._sp) {
    packSize = _sp.getInt(_packSize) ?? 10;
    autoPronouncingInLearnPage =
        _sp.getBool(_autoPronouncingInLearnPage) ?? true;
    frontCardInLearnPageTerm = _sp.getBool(_frontCardInLearnPageTerm) ?? true;
    frontCardInLearnPageDefinition =
        _sp.getBool(_frontCardInLearnPageDefinition) ?? true;
    isFirstOpening = _sp.getBool(_isFirstOpening) ?? true;
    einkMode = _sp.getBool(_einkMode) ?? false;
    safeArea = _sp.getBool(_safeArea) ?? false;
    useYandexTranslator = _sp.getBool(_useYandexTranslator) ?? false;
    useDeeplTranslator = _sp.getBool(_useDeeplTranslator) ?? true;
    useGoogleTranslator = _sp.getBool(_useGoogleTranslator) ?? true;
    translatorOrderIndexes = _sp
            .getStringList(_translatorOrderIndexes)
            ?.map((e) => int.parse(e))
            .toList() ??
        [0, 1, 2, 3];
    if (translatorOrderIndexes.length != 4) {
      setTranslatorOrderIndexes([0, 1, 2, 3]);
    }
    learningAutoPronouncing = _sp.getBool(_learningAutoPronouncing) ?? true;
    ttsMaxRate = _sp.getDouble(_ttsMaxRate) ?? 0.3;
    ttsMinRate = _sp.getDouble(_ttsMinRate) ?? 0.15;
  }

  @action
  Future setPackSize(int size) async {
    await _sp.setInt(_packSize, size);
    packSize = size;
  }

  @action
  Future setAutoPronouncingInLearnPage(bool value) async {
    await _sp.setBool(_autoPronouncingInLearnPage, value);
    autoPronouncingInLearnPage = value;
  }

  @action
  Future setFrontCardInLearnPageTerm(bool value) async {
    await _sp.setBool(_frontCardInLearnPageTerm, value);
    frontCardInLearnPageTerm = value;
  }

  @action
  Future setFrontCardInLearnPageDefinition(bool value) async {
    await _sp.setBool(_frontCardInLearnPageDefinition, value);
    frontCardInLearnPageDefinition = value;
  }

  @action
  Future setIsFirstOpening(bool value) async {
    await _sp.setBool(_isFirstOpening, value);
    isFirstOpening = value;
  }

  @action
  Future setEinkMode(bool value) async {
    getIt<ToastController>().showDefaultTost("Eink mode is not supported yet");
    return;
    await _sp.setBool(_einkMode, value);
    einkMode = value;
  }

  @action
  Future setSafeArea(bool value) async {
    await _sp.setBool(_safeArea, value);
    safeArea = value;
  }

  @action
  Future setUseYaTranslator(bool value) async {
    await _sp.setBool(_useYandexTranslator, value);
    useYandexTranslator = value;
  }

  @action
  Future setUseDeeplTranslator(bool value) async {
    await _sp.setBool(_useDeeplTranslator, value);
    useDeeplTranslator = value;
  }

  @action
  Future setUseGoogleTranslator(bool value) async {
    await _sp.setBool(_useGoogleTranslator, value);
    useGoogleTranslator = value;
  }

  @action
  Future setTranslatorOrderIndexes(List<int> value) async {
    await _sp.setStringList(
        _translatorOrderIndexes, value.map((e) => e.toString()).toList());
    translatorOrderIndexes = value;
  }

  @action
  Future setLearningAutoPronouncing(bool value) async {
    await _sp.setBool(_learningAutoPronouncing, value);
    learningAutoPronouncing = value;
  }

  @action
  Future setTtsMaxRate(double value) async {
    await _sp.setDouble(_ttsMaxRate, value);
    ttsMaxRate = value;
  }

  @action
  Future setTtsMinRate(double value) async {
    await _sp.setDouble(_ttsMinRate, value);
    ttsMinRate = value;
  }
}
