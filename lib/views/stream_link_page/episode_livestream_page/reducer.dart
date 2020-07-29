import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episode_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeLiveStreamState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeLiveStreamState>>{
      EpisodeLiveStreamAction.action: _onAction,
      EpisodeLiveStreamAction.setSelectedEpisode: _setSelectedEpisode,
      EpisodeLiveStreamAction.selectedStreamLink: _selectedStreamLink,
      EpisodeLiveStreamAction.setComment: _setComment,
      EpisodeLiveStreamAction.setLike: _setLike,
      EpisodeLiveStreamAction.setStreamLink: _setStreamLink,
      EpisodeLiveStreamAction.setLoading: _setLoading,
    },
  );
}

EpisodeLiveStreamState _onAction(EpisodeLiveStreamState state, Action action) {
  final EpisodeLiveStreamState newState = state.clone();
  return newState;
}

EpisodeLiveStreamState _setSelectedEpisode(
    EpisodeLiveStreamState state, Action action) {
  final Episode _episode = action.payload[0];
  final TvShowStreamLink _link = action.payload[1];
  final EpisodeLiveStreamState newState = state.clone();
  newState.selectedEpisode = _episode;
  newState.selectedLink = _link;
  return newState;
}

EpisodeLiveStreamState _setComment(
    EpisodeLiveStreamState state, Action action) {
  final _comments = action.payload;
  final EpisodeLiveStreamState newState = state.clone();
  newState.bottomPanelState.commentState.comments = _comments;
  return newState;
}

EpisodeLiveStreamState _setLike(EpisodeLiveStreamState state, Action action) {
  final int _count = action.payload[0] ?? 0;
  final bool _like = action.payload[1] ?? false;
  final EpisodeLiveStreamState newState = state.clone();
  newState.bottomPanelState.likeCount = _count;
  newState.bottomPanelState.userLiked = _like;
  return newState;
}

EpisodeLiveStreamState _setStreamLink(
    EpisodeLiveStreamState state, Action action) {
  final TvShowStreamLinks _streamLinks = action.payload[0];
  final TvShowStreamLink _link = action.payload[1];
  final EpisodeLiveStreamState newState = state.clone();
  newState.selectedLink = _link;
  newState.streamLinks = _streamLinks;
  newState.loading = false;
  return newState;
}

EpisodeLiveStreamState _selectedStreamLink(
    EpisodeLiveStreamState state, Action action) {
  final TvShowStreamLink _link = action.payload;
  final EpisodeLiveStreamState newState = state.clone();
  newState.selectedLink = _link;
  return newState;
}

EpisodeLiveStreamState _setLoading(
    EpisodeLiveStreamState state, Action action) {
  final bool _loading = action.payload;
  final EpisodeLiveStreamState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
