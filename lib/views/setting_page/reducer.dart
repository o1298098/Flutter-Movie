import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingPageState>>{
      SettingPageAction.action: _onAction,
      SettingPageAction.adultValueUpadte: _adultValueUpadte,
      SettingPageAction.cachedSizeUpdate: _cachedSizeUpdate,
      SettingPageAction.profileEdit: _profileEdit,
    },
  );
}

SettingPageState _onAction(SettingPageState state, Action action) {
  final SettingPageState newState = state.clone();
  return newState;
}

SettingPageState _adultValueUpadte(SettingPageState state, Action action) {
  final bool _b = action.payload;
  final SettingPageState newState = state.clone();
  newState.adultSwitchValue = _b;
  return newState;
}

SettingPageState _cachedSizeUpdate(SettingPageState state, Action action) {
  final double _c = action.payload;
  final SettingPageState newState = state.clone();
  newState.cachedSize = _c;
  return newState;
}

SettingPageState _profileEdit(SettingPageState state, Action action) {
  final bool _isEdit = action.payload ?? false;
  final SettingPageState newState = state.clone();
  newState.isEditProfile = _isEdit;
  return newState;
}
