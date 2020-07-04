import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episodemodel.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeLiveStreamState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeLiveStreamState>>{
      EpisodeLiveStreamAction.action: _onAction,
      EpisodeLiveStreamAction.setSelectedEpisode: _setSelectedEpisode
    },
  );
}

EpisodeLiveStreamState _onAction(EpisodeLiveStreamState state, Action action) {
  final EpisodeLiveStreamState newState = state.clone();
  return newState;
}

EpisodeLiveStreamState _setSelectedEpisode(
    EpisodeLiveStreamState state, Action action) {
  final Episode _episode = action.payload;
  final EpisodeLiveStreamState newState = state.clone();
  newState.selectedEpisode = _episode;
  return newState;
}
