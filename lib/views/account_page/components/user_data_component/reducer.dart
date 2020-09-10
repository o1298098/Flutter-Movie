import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<UserDataState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserDataState>>{
      UserDataAction.action: _onAction,
      UserDataAction.setInfo: _setInfo,
    },
  );
}

UserDataState _onAction(UserDataState state, Action action) {
  final UserDataState newState = state.clone();
  return newState;
}

UserDataState _setInfo(UserDataState state, Action action) {
  final AccountInfo _info = action.payload;
  final UserDataState newState = state.clone();
  newState.info = _info;
  return newState;
}
