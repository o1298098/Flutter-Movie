import 'package:fish_redux/fish_redux.dart';
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
