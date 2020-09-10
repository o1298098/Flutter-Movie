import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TrendingCellState> buildReducer() {
  return asReducer(
    <Object, Reducer<TrendingCellState>>{
      TrendingCellAction.action: _onAction,
    },
  );
}

TrendingCellState _onAction(TrendingCellState state, Action action) {
  final TrendingCellState newState = state.clone();
  return newState;
}
