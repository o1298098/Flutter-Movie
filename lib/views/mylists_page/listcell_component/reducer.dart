import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListCellState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListCellState>>{
      ListCellAction.action: _onAction,
    },
  );
}

ListCellState _onAction(ListCellState state, Action action) {
  final ListCellState newState = state.clone();
  return newState;
}
