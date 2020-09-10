import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegisterPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterPageState>>{
      RegisterPageAction.action: _onAction,
    },
  );
}

RegisterPageState _onAction(RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  return newState;
}
