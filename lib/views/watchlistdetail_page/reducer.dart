import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WatchlistDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<WatchlistDetailPageState>>{
      WatchlistDetailPageAction.action: _onAction,
    },
  );
}

WatchlistDetailPageState _onAction(WatchlistDetailPageState state, Action action) {
  final WatchlistDetailPageState newState = state.clone();
  return newState;
}
