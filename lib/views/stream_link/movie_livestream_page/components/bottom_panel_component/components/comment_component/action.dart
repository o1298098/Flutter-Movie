import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';

enum CommentAction {
  action,
  loadMore,
  addComment,
  insertComment,
}

class CommentActionCreator {
  static Action onAction() {
    return const Action(CommentAction.action);
  }

  static Action loadMore(MovieComments comments) {
    return Action(CommentAction.loadMore, payload: comments);
  }

  static Action addComment(String comment) {
    return Action(CommentAction.addComment, payload: comment);
  }

  static Action insertComment(MovieComment comment) {
    return Action(CommentAction.insertComment, payload: comment);
  }
}
