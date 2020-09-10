import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayerState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlayerState>>{
      PlayerAction.action: _onAction,
    },
  );
}

PlayerState _onAction(PlayerState state, Action action) {
  final PlayerState newState = state.clone();
  return newState;
}
