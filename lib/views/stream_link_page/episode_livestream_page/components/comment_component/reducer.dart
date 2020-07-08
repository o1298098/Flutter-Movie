import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';

import 'action.dart';
import 'state.dart';

Reducer<CommentState> buildReducer() {
  return asReducer(
    <Object, Reducer<CommentState>>{
      CommentAction.action: _onAction,
      CommentAction.insertComment: _insertComment,
      CommentAction.loadMore: _loadMore,
    },
  );
}

CommentState _onAction(CommentState state, Action action) {
  final CommentState newState = state.clone();
  return newState;
}

CommentState _insertComment(CommentState state, Action action) {
  final TvShowComment _comment = action.payload;
  final CommentState newState = state.clone();
  if (_comment != null) {
    newState.comments.data.insert(0, _comment);
    newState.comments.totalCount++;
    newState.comments = TvShowComments.fromParams(
        data: newState.comments.data,
        page: newState.comments.page,
        totalCount: newState.comments.totalCount);
  }
  return newState;
}

CommentState _loadMore(CommentState state, Action action) {
  final TvShowComments _comments = action.payload;
  final CommentState newState = state.clone();
  if (_comments != null) {
    newState.comments.data.addAll(_comments.data);
    newState.comments = TvShowComments.fromParams(
        data: newState.comments.data,
        page: _comments.page,
        totalCount: _comments.totalCount);
  }
  return newState;
}
