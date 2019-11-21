import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';

import 'action.dart';
import 'state.dart';

Reducer<TvShowLiveStreamPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TvShowLiveStreamPageState>>{
      TvShowLiveStreamPageAction.action: _onAction,
      TvShowLiveStreamPageAction.setStreamLinks: _setStreamLinks,
      TvShowLiveStreamPageAction.episodeChanged: _episodeChanged,
    },
  );
}

TvShowLiveStreamPageState _onAction(
    TvShowLiveStreamPageState state, Action action) {
  final TvShowLiveStreamPageState newState = state.clone();
  return newState;
}

TvShowLiveStreamPageState _setStreamLinks(
    TvShowLiveStreamPageState state, Action action) {
  final TvShowStreamLinks model = action.payload;
  final TvShowLiveStreamPageState newState = state.clone();
  newState.streamLinks = model;
  return newState;
}

TvShowLiveStreamPageState _episodeChanged(
    TvShowLiveStreamPageState state, Action action) {
  final int ep = action.payload;
  final TvShowLiveStreamPageState newState = state.clone();
  newState.selectedEpisode = ep;
  return newState;
}
