import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingPageState>>{
      SettingPageAction.action: _onAction,
    },
  );
}

SettingPageState _onAction(SettingPageState state, Action action) {
  final SettingPageState newState = state.clone();
  return newState;
}
