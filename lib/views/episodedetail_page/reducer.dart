import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeDetailPageState>>{
      EpisodeDetailPageAction.action: _onAction,
    },
  );
}

EpisodeDetailPageState _onAction(EpisodeDetailPageState state, Action action) {
  final EpisodeDetailPageState newState = state.clone();
  return newState;
}
