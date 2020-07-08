import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/episodemodel.dart';

enum EpisodeLiveStreamAction {
  action,
  episodeTapped,
  setSelectedEpisode,
  setComment,
  setLike,
  likeTvShow,
  commentTap,
}

class EpisodeLiveStreamActionCreator {
  static Action episodeTapped(Episode episode) {
    return Action(EpisodeLiveStreamAction.episodeTapped, payload: episode);
  }

  static Action setSelectedEpisode(Episode episode) {
    return Action(EpisodeLiveStreamAction.setSelectedEpisode, payload: episode);
  }

  static Action setComment(TvShowComments comment) {
    return Action(EpisodeLiveStreamAction.setComment, payload: comment);
  }

  static Action setLike(int likeCount, bool userLiked) {
    return Action(EpisodeLiveStreamAction.setLike,
        payload: [likeCount, userLiked]);
  }

  static Action likeTvShow() {
    return const Action(EpisodeLiveStreamAction.likeTvShow);
  }

  static Action commentTap() {
    return const Action(EpisodeLiveStreamAction.commentTap);
  }
}
