import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TrailerState> buildReducer() {
  return asReducer(
    <Object, Reducer<TrailerState>>{
      TrailerAction.action: _onAction,
    },
  );
}

TrailerState _onAction(TrailerState state, Action action) {
  final TrailerState newState = state.clone();
  return newState;
}
