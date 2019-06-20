import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieCellsState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieCellsState>>{
      MovieCellsAction.action: _onAction,
    },
  );
}

MovieCellsState _onAction(MovieCellsState state, Action action) {
  final MovieCellsState newState = state.clone();
  return newState;
}
