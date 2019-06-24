import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VideoCellState> buildReducer() {
  return asReducer(
    <Object, Reducer<VideoCellState>>{
      MovieCellAction.action: _onAction,
    },
  );
}

VideoCellState _onAction(VideoCellState state, Action action) {
  final VideoCellState newState = state.clone();
  return newState;
}
