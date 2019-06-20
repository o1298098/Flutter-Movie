import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountPageState>>{
      AccountPageAction.action: _onAction,
    },
  );
}

AccountPageState _onAction(AccountPageState state, Action action) {
  final AccountPageState newState = state.clone();
  return newState;
}
