import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HeaderState> buildReducer() {
  return asReducer(
    <Object, Reducer<HeaderState>>{
      HeaderAction.action: _onAction,
      HeaderAction.widthChanged: _widthChanged,
    },
  );
}

HeaderState _onAction(HeaderState state, Action action) {
  final HeaderState newState = state.clone();
  return newState;
}

HeaderState _widthChanged(HeaderState state, Action action) {
  final bool isMovie = action.payload ?? false;
  final HeaderState newState = state.clone();
  newState.isMovie = isMovie;
  if (isMovie && newState.movies?.data != null)
    newState.selectMdeia = newState.movies.data[0];
  else if (!isMovie && newState.tvshows?.data != null)
    newState.selectMdeia = newState.tvshows.data[0];
  else
    newState.selectMdeia = null;
  return newState;
}
