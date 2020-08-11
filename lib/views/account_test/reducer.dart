import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountState>>{
      AccountAction.action: _onAction,
      AccountAction.onTabBarTap: _onTabBarTap,
      AccountAction.showTip: _showTip,
    },
  );
}

AccountState _onAction(AccountState state, Action action) {
  final AccountState newState = state.clone();
  return newState;
}

AccountState _onTabBarTap(AccountState state, Action action) {
  final int _index = action.payload ?? 0;
  final AccountState newState = state.clone();
  newState.selectedTabBarIndex = _index;
  return newState;
}

AccountState _showTip(AccountState state, Action action) {
  final bool _show = action.payload ?? true;
  final AccountState newState = state.clone();
  newState.showTip = _show;
  return newState;
}
