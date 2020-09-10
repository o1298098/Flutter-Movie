import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeState>>{
      EpisodeAction.action: _onAction,
    },
  );
}

EpisodeState _onAction(EpisodeState state, Action action) {
  final EpisodeState newState = state.clone();
  return newState;
}
