import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';

enum LiveStreamPageAction {
  action,
  setStreamLinks,
  setComment,
  chipSelected,
  commentChanged,
  addComment,
  insertComment,
  videoPlayerUpdate,
}

class LiveStreamPageActionCreator {
  static Action onAction() {
    return const Action(LiveStreamPageAction.action);
  }

  static Action videoPlayerUpdate() {
    return Action(LiveStreamPageAction.videoPlayerUpdate);
  }

  static Action setStreamLinks(List<MovieStreamLink> streamLinks) {
    return Action(LiveStreamPageAction.setStreamLinks, payload: streamLinks);
  }

  static Action chipSelected(MovieStreamLink d) {
    return Action(LiveStreamPageAction.chipSelected, payload: d);
  }

  static Action setComment(MovieComments comment) {
    return Action(LiveStreamPageAction.setComment, payload: comment);
  }

  static Action commentChanged(String comment) {
    return Action(LiveStreamPageAction.commentChanged, payload: comment);
  }

  static Action addComment(String comment) {
    return Action(LiveStreamPageAction.addComment, payload: comment);
  }

  static Action insertComment(MovieComment comment) {
    return Action(LiveStreamPageAction.insertComment, payload: comment);
  }
}
