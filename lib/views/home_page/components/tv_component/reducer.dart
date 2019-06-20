import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TVCellsState> buildReducer() {
  return asReducer(
    <Object, Reducer<TVCellsState>>{
      TVCellsAction.action: _onAction,
    },
  );
}

TVCellsState _onAction(TVCellsState state, Action action) {
  final TVCellsState newState = state.clone();
  return newState;
}
