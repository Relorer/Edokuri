// 🎯 Dart imports:

// 📦 Package imports:
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:

part 'settings_controller.g.dart';

const _packSize = "PACKSIZE";
const _autoPronouncingInLearnPage = "AUTOPRONOUNCINGINLEARNPAGE";
const _frontCardInLearnPageTerm = "FRONTCARDINLEARNPAGE_TERM";
const _frontCardInLearnPageDefinition = "FRONTCARDINLEARNPAGE_DEFINITION";
const _isFirstOpening = "ISFIRSTOPENING";
const _einkMode = "EINKMODE";
const _safeArea = "SAFEAREA";

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
    await _sp.setBool(_einkMode, value);
    einkMode = value;
  }

  @action
  Future setSafeArea(bool value) async {
    await _sp.setBool(_safeArea, value);
    safeArea = value;
  }
}
