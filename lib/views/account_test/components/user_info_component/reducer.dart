import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<UserInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserInfoState>>{
      UserInfoAction.action: _onAction,
    },
  );
}

UserInfoState _onAction(UserInfoState state, Action action) {
  final UserInfoState newState = state.clone();
  return newState;
}
