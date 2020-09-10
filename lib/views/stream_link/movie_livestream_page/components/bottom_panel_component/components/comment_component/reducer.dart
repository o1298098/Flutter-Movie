import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';

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
  final MovieComment _comment = action.payload;
  final CommentState newState = state.clone();
  if (_comment != null) {
    newState.comments.data.insert(0, _comment);
    newState.comments.totalCount++;
  }
  return newState;
}

CommentState _loadMore(CommentState state, Action action) {
  final MovieComments _comments = action.payload;
  final CommentState newState = state.clone();
  if (_comments != null) {
    final _newComments = MovieComments.fromParams(
        data: state.comments.data,
        page: _comments.page,
        totalCount: _comments.totalCount);
    _newComments.data.addAll(_comments.data);
    newState.comments = _newComments;
  }
  return newState;
}
