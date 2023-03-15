// 📦 Package imports:
import 'package:shared_preferences/shared_preferences.dart';

const _packSize = "PACKSIZE";
const _autoPronouncingInLearnPage = "AUTOPRONOUNCINGINLEARNPAGE";
const _frontCardInLearnPageTerm = "FRONTCARDINLEARNPAGE_TERM";
const _frontCardInLearnPageDefinition = "FRONTCARDINLEARNPAGE_DEFINITION";
const _isFirstOpening = "ISFIRSTOPENING";

class SettingsControllerFactory {
  Future<SettingsController> getSettingsController() async {
    return SettingsController(await SharedPreferences.getInstance());
  }
}

class SettingsController {
  final SharedPreferences _sp;

  SettingsController(this._sp);

  int get packSize => _sp.getInt(_packSize) ?? 10;
  bool get autoPronouncingInLearnPage =>
      _sp.getBool(_autoPronouncingInLearnPage) ?? true;
  bool get frontCardInLearnPageTerm =>
      _sp.getBool(_frontCardInLearnPageTerm) ?? true;
  bool get frontCardInLearnPageDefinition =>
      _sp.getBool(_frontCardInLearnPageDefinition) ?? true;
  bool get isFirstOpening => _sp.getBool(_isFirstOpening) ?? true;

  void setPackSize(int size) {
    _sp.setInt(_packSize, size);
  }

  void setAutoPronouncingInLearnPage(bool value) {
    _sp.setBool(_autoPronouncingInLearnPage, value);
  }

  void setFrontCardInLearnPageTerm(bool value) {
    _sp.setBool(_frontCardInLearnPageTerm, value);
  }

  void setFrontCardInLearnPageDefinition(bool value) {
    _sp.setBool(_frontCardInLearnPageDefinition, value);
  }

  void setIsFirstOpening(bool value) {
    _sp.setBool(_isFirstOpening, value);
  }
}
