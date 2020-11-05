import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episode_model.dart';

enum EpisodeLiveStreamAction {
  action,
  episodeTapped,
  setSelectedEpisode,
  setComment,
  setStreamLink,
  selectedStreamLink,
  setLike,
  setLoading,
  markWatched,
}

class EpisodeLiveStreamActionCreator {
  static Action episodeTapped(Episode episode) {
    return Action(EpisodeLiveStreamAction.episodeTapped, payload: episode);
  }

  static Action setSelectedEpisode(Episode episode, TvShowStreamLink link) {
    return Action(EpisodeLiveStreamAction.setSelectedEpisode,
        payload: [episode, link]);
  }

  static Action setComment(TvShowComments comment) {
    return Action(EpisodeLiveStreamAction.setComment, payload: comment);
  }

  static Action setLike(int likeCount, bool userLiked) {
    return Action(EpisodeLiveStreamAction.setLike,
        payload: [likeCount, userLiked]);
  }

  static Action setStreamLink(
      TvShowStreamLinks streamLinks, TvShowStreamLink selectedLink) {
    return Action(EpisodeLiveStreamAction.setStreamLink,
        payload: [streamLinks, selectedLink]);
  }

  static Action selectedStreamLink(TvShowStreamLink streamLink) {
    return Action(EpisodeLiveStreamAction.selectedStreamLink,
        payload: streamLink);
  }

  static Action setLoading(bool loading) {
    return Action(EpisodeLiveStreamAction.setLoading, payload: loading);
  }

  static Action markWatched(Episode episode) {
    return Action(EpisodeLiveStreamAction.markWatched, payload: episode);
  }
}
