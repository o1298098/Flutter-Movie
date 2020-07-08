import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TvPlayerState> buildReducer() {
  return asReducer(
    <Object, Reducer<TvPlayerState>>{
      TvPlayerAction.action: _onAction,
    },
  );
}

TvPlayerState _onAction(TvPlayerState state, Action action) {
  final TvPlayerState newState = state.clone();
  return newState;
}
