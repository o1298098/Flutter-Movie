import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';

enum EpisodeLiveStreamAction {
  action,
  episodeTapped,
  setSelectedEpisode,
  setComment,
  setStreamLink,
  setOption,
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

  static Action setStreamLink(TvShowStreamLinks streamLinks) {
    return Action(EpisodeLiveStreamAction.setStreamLink, payload: streamLinks);
  }

  static Action setOption(bool useVideoSourceApi, bool streamInBrowser) {
    return Action(EpisodeLiveStreamAction.setOption,
        payload: [useVideoSourceApi, streamInBrowser]);
  }
}
