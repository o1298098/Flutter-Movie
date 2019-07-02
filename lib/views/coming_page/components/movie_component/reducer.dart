import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieListState>>{
      MovieListAction.action: _onAction,
    },
  );
}

MovieListState _onAction(MovieListState state, Action action) {
  final MovieListState newState = state.clone();
  return newState;
}
