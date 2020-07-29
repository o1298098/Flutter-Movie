import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episode_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeDetailPageState>>{
      EpisodeDetailPageAction.action: _onAction,
      EpisodeDetailPageAction.updateEpisodeDetail: _onUpdateEpisodeDetail
    },
  );
}

EpisodeDetailPageState _onAction(EpisodeDetailPageState state, Action action) {
  final EpisodeDetailPageState newState = state.clone();
  return newState;
}

EpisodeDetailPageState _onUpdateEpisodeDetail(
    EpisodeDetailPageState state, Action action) {
  Episode model = action.payload ?? Episode.fromParams();
  final EpisodeDetailPageState newState = state.clone();
  newState.episode = model;
  return newState;
}
