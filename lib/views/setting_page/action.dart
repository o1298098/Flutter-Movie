import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SettingPageAction {
  action,
  adultCellTapped,
  adultValueUpadte,
  cleanCached,
  cachedSizeUpdate,
  profileEdit,
}

class SettingPageActionCreator {
  static Action onAction() {
    return const Action(SettingPageAction.action);
  }

  static Action adultCellTapped() {
    return Action(SettingPageAction.adultCellTapped);
  }

  static Action adultValueUpadte(bool b) {
    return Action(SettingPageAction.adultValueUpadte, payload: b);
  }

  static Action cleanCached() {
    return Action(SettingPageAction.cleanCached);
  }

  static Action cacheSizeUpdate(double d) {
    return Action(SettingPageAction.cachedSizeUpdate, payload: d);
  }

  static Action profileEdit(bool b) {
    return Action(SettingPageAction.profileEdit, payload: b);
  }
}
