import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<Theme2State> buildReducer() {
  return asReducer(
    <Object, Reducer<Theme2State>>{
      Theme2Action.action: _onAction,
    },
  );
}

Theme2State _onAction(Theme2State state, Action action) {
  final Theme2State newState = state.clone();
  return newState;
}
