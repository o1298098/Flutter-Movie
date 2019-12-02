import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/models/firebase/firebase_streamlink.dart';

import 'action.dart';
import 'state.dart';

Reducer<LiveStreamPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<LiveStreamPageState>>{
      LiveStreamPageAction.action: _onAction,
      LiveStreamPageAction.setStreamLinks: _setStreamLinks,
      LiveStreamPageAction.commentChanged: _commentChanged,
      LiveStreamPageAction.setComment: _setComment,
      LiveStreamPageAction.insertComment: _insertComment
    },
  );
}

LiveStreamPageState _onAction(LiveStreamPageState state, Action action) {
  final LiveStreamPageState newState = state.clone();
  return newState;
}

LiveStreamPageState _setComment(LiveStreamPageState state, Action action) {
  final MovieComments comments = action.payload;
  final LiveStreamPageState newState = state.clone();
  newState.comments = comments;
  return newState;
}

LiveStreamPageState _insertComment(LiveStreamPageState state, Action action) {
  final MovieComment comment = action.payload;
  final LiveStreamPageState newState = state.clone();
  if (newState.comments != null) newState.comments.data.insert(0, comment);
  return newState;
}

LiveStreamPageState _commentChanged(LiveStreamPageState state, Action action) {
  final String comment = action.payload;
  final LiveStreamPageState newState = state.clone();
  newState.comment = comment;
  return newState;
}

LiveStreamPageState _setStreamLinks(LiveStreamPageState state, Action action) {
  final List<MovieStreamLink> streamLinks = action.payload ?? [];
  final LiveStreamPageState newState = state.clone();
  newState.streamLinks = streamLinks;
  return newState;
}
