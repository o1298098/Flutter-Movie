import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/item.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingsState>>{
      SettingsAction.action: _onAction,
      SettingsAction.adultContentUpadte: _adultContentUpadte,
      SettingsAction.setLanguage: _setLanguage,
      SettingsAction.notificationsUpdate: _notificationsUpdate,
    },
  );
}

SettingsState _onAction(SettingsState state, Action action) {
  final SettingsState newState = state.clone();
  return newState;
}

SettingsState _adultContentUpadte(SettingsState state, Action action) {
  final bool _adult = action.payload;
  final SettingsState newState = state.clone();
  newState.adultContent = _adult;
  return newState;
}

SettingsState _notificationsUpdate(SettingsState state, Action action) {
  final bool _enbale = action.payload;
  final SettingsState newState = state.clone();
  newState.enableNotifications = _enbale;
  return newState;
}

SettingsState _setLanguage(SettingsState state, Action action) {
  Item _language = action.payload;
  final SettingsState newState = state.clone();
  newState.appLanguage = _language;
  return newState;
}
