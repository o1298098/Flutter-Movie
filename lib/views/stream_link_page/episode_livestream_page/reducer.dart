import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodeLiveStreamState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodeLiveStreamState>>{
      EpisodeLiveStreamAction.action: _onAction,
      EpisodeLiveStreamAction.setSelectedEpisode: _setSelectedEpisode,
      EpisodeLiveStreamAction.setComment: _setComment,
      EpisodeLiveStreamAction.setLike: _setLike,
      EpisodeLiveStreamAction.setStreamLink: _setStreamLink,
      EpisodeLiveStreamAction.setOption: _setOption
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

EpisodeLiveStreamState _setComment(
    EpisodeLiveStreamState state, Action action) {
  final _comments = action.payload;
  final EpisodeLiveStreamState newState = state.clone();
  newState.comments = _comments;
  newState.commentState = newState.commentState.clone()..comments = _comments;
  return newState;
}

EpisodeLiveStreamState _setLike(EpisodeLiveStreamState state, Action action) {
  final int _count = action.payload[0] ?? 0;
  final bool _like = action.payload[1] ?? false;
  final EpisodeLiveStreamState newState = state.clone();
  newState.likeCount = _count;
  newState.userliked = _like;
  return newState;
}

EpisodeLiveStreamState _setStreamLink(
    EpisodeLiveStreamState state, Action action) {
  final TvShowStreamLinks _streamLinks = action.payload;
  final EpisodeLiveStreamState newState = state.clone();
  newState.streamLinks = _streamLinks;
  return newState;
}

EpisodeLiveStreamState _setOption(EpisodeLiveStreamState state, Action action) {
  final bool _api = action.payload[0];
  final bool _streamInBrowser = action.payload[1];
  final EpisodeLiveStreamState newState = state.clone();
  newState.useVideoSourceApi = _api;
  newState.streamInBrowser = _streamInBrowser;
  return newState;
}
