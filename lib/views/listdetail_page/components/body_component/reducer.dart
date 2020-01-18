import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BodyState> buildReducer() {
  return asReducer(
    <Object, Reducer<BodyState>>{
      BodyAction.action: _onAction,
    },
  );
}

BodyState _onAction(BodyState state, Action action) {
  final BodyState newState = state.clone();
  return newState;
}
