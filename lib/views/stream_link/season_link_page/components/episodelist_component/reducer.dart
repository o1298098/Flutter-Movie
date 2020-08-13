import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/season_detail.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeListState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeListState>>{
      EpisodeListAction.action: _onAction,
      EpisodeListAction.updateSeason: _updateSeason
    },
  );
}

EpisodeListState _onAction(EpisodeListState state, Action action) {
  final EpisodeListState newState = state.clone();
  return newState;
}

EpisodeListState _updateSeason(EpisodeListState state, Action action) {
  final Season _season = action.payload;
  final EpisodeListState newState = state.clone();
  newState.season = _season;
  return newState;
}
