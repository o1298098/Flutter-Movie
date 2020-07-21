import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieLiveStreamState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieLiveStreamState>>{
      MovieLiveStreamAction.action: _onAction,
      MovieLiveStreamAction.selectedStreamLink: _selectedStreamLink,
      MovieLiveStreamAction.setComment: _setComment,
      MovieLiveStreamAction.setLike: _setLike,
      MovieLiveStreamAction.setStreamLink: _setStreamLink,
      MovieLiveStreamAction.setLoading: _setLoading
    },
  );
}

MovieLiveStreamState _onAction(MovieLiveStreamState state, Action action) {
  final MovieLiveStreamState newState = state.clone();
  return newState;
}

MovieLiveStreamState _setComment(MovieLiveStreamState state, Action action) {
  final _comments = action.payload;
  final MovieLiveStreamState newState = state.clone();
  newState.bottomPanelState.commentState.comments = _comments;
  return newState;
}

MovieLiveStreamState _setLike(MovieLiveStreamState state, Action action) {
  final int _count = action.payload[0] ?? 0;
  final bool _like = action.payload[1] ?? false;
  final MovieLiveStreamState newState = state.clone();
  newState.bottomPanelState.likeCount = _count;
  newState.bottomPanelState.userLiked = _like;
  return newState;
}

MovieLiveStreamState _setStreamLink(MovieLiveStreamState state, Action action) {
  final MovieStreamLinks _streamLinks = action.payload[0];
  final MovieStreamLink _link = action.payload[1];
  final MovieLiveStreamState newState = state.clone();
  newState.selectedLink = _link;
  newState.streamLinks = _streamLinks;
  newState.loading = false;
  return newState;
}

MovieLiveStreamState _selectedStreamLink(
    MovieLiveStreamState state, Action action) {
  final MovieStreamLink _link = action.payload;
  final MovieLiveStreamState newState = state.clone();
  newState.selectedLink = _link;
  return newState;
}

MovieLiveStreamState _setLoading(MovieLiveStreamState state, Action action) {
  final bool _loading = action.payload;
  final MovieLiveStreamState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
