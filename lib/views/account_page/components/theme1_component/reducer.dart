import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<Theme1State> buildReducer() {
  return asReducer(
    <Object, Reducer<Theme1State>>{
      Theme1Action.action: _onAction,
    },
  );
}

Theme1State _onAction(Theme1State state, Action action) {
  final Theme1State newState = state.clone();
  return newState;
}
