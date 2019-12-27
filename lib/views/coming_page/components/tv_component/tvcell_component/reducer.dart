import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TVCellState> buildReducer() {
  return asReducer(
    <Object, Reducer<TVCellState>>{
      TVCellAction.action: _onAction,
    },
  );
}

TVCellState _onAction(TVCellState state, Action action) {
  final TVCellState newState = state.clone();
  return newState;
}
