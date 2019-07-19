import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SeasonsPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SeasonsPageState>>{
      SeasonsPageAction.action: _onAction,
    },
  );
}

SeasonsPageState _onAction(SeasonsPageState state, Action action) {
  final SeasonsPageState newState = state.clone();
  return newState;
}
