import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CastState> buildReducer() {
  return asReducer(
    <Object, Reducer<CastState>>{
      CastAction.action: _onAction,
    },
  );
}

CastState _onAction(CastState state, Action action) {
  final CastState newState = state.clone();
  return newState;
}
