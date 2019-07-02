import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PopularState> buildReducer() {
  return asReducer(
    <Object, Reducer<PopularState>>{
      PopularAction.action: _onAction,
    },
  );
}

PopularState _onAction(PopularState state, Action action) {
  final PopularState newState = state.clone();
  return newState;
}
