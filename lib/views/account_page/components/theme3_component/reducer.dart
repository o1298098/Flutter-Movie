import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<Theme3State> buildReducer() {
  return asReducer(
    <Object, Reducer<Theme3State>>{
      Theme3Action.action: _onAction,
    },
  );
}

Theme3State _onAction(Theme3State state, Action action) {
  final Theme3State newState = state.clone();
  return newState;
}
