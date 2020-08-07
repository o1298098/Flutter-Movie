import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountState>>{
      AccountAction.action: _onAction,
    },
  );
}

AccountState _onAction(AccountState state, Action action) {
  final AccountState newState = state.clone();
  return newState;
}
