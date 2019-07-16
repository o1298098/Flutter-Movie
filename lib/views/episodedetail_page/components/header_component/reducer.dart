import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeHeaderState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeHeaderState>>{
      EpisodeHeaderAction.action: _onAction,
    },
  );
}

EpisodeHeaderState _onAction(EpisodeHeaderState state, Action action) {
  final EpisodeHeaderState newState = state.clone();
  return newState;
}
