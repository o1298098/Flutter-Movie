import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountPageState>>{
      AccountPageAction.action: _onAction,
      AccountPageAction.init: _onInit,
    },
  );
}

AccountPageState _onAction(AccountPageState state, Action action) {
  final AccountPageState newState = state.clone();
  return newState;
}

AccountPageState _onInit(AccountPageState state, Action action) {
  final String name = action.payload[0] ?? 'Guest';
  final String avatar = action.payload[1] ?? 'https://www.gravatar.com/avatar/';
  final bool islogin = action.payload[2] ?? false;
  final AccountPageState newState = state.clone();
  newState.name = name;
  newState.avatar = avatar;
  newState.islogin = islogin;
  return newState;
}
