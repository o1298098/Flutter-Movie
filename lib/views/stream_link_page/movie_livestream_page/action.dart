import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';

enum MovieLiveStreamAction {
  action,
  getLike,
  getComment,
  setComment,
  setStreamLink,
  selectedStreamLink,
  setLoading,
  setLike,
}

class MovieLiveStreamActionCreator {
  static Action onAction() {
    return const Action(MovieLiveStreamAction.action);
  }

  static Action getLike() {
    return const Action(MovieLiveStreamAction.getLike);
  }

  static Action getComment() {
    return const Action(MovieLiveStreamAction.getComment);
  }

  static Action setComment(MovieComments comment) {
    return Action(MovieLiveStreamAction.setComment, payload: comment);
  }

  static Action setLike(int likeCount, bool userLiked) {
    return Action(MovieLiveStreamAction.setLike,
        payload: [likeCount, userLiked]);
  }

  static Action setStreamLink(
      MovieStreamLinks streamLinks, MovieStreamLink selectedLink) {
    return Action(MovieLiveStreamAction.setStreamLink,
        payload: [streamLinks, selectedLink]);
  }

  static Action setLoading(bool loading) {
    return Action(MovieLiveStreamAction.setLoading, payload: loading);
  }
}
