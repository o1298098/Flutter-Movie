import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TestState> buildReducer() {
  return asReducer(
    <Object, Reducer<TestState>>{
      TestAction.action: _onAction,
    },
  );
}

TestState _onAction(TestState state, Action action) {
  final TestState newState = state.clone();
  newState.value = action.payload ?? 0;
  return newState;
}
