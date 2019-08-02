import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WatchlistPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<WatchlistPageState>>{
      WatchlistPageAction.action: _onAction,
    },
  );
}

WatchlistPageState _onAction(WatchlistPageState state, Action action) {
  final WatchlistPageState newState = state.clone();
  return newState;
}
