import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/views/stream_link_page/episode_livestream_page/state.dart';

class BottomPanelState implements Cloneable<BottomPanelState> {
  TvShowStreamLinks streamLinks;
  bool useVideoSourceApi;
  bool streamInBrowser;
  bool userLiked;
  int likeCount;
  int commentCount;
  int selectEpisode;
  @override
  BottomPanelState clone() {
    return BottomPanelState()
      ..userLiked = userLiked
      ..useVideoSourceApi = useVideoSourceApi
      ..streamInBrowser = streamInBrowser
      ..likeCount = likeCount
      ..streamLinks = streamLinks
      ..commentCount = commentCount
      ..selectEpisode = selectEpisode;
  }
}

class BottomPanelConnector
    extends ConnOp<EpisodeLiveStreamState, BottomPanelState> {
  @override
  BottomPanelState get(EpisodeLiveStreamState state) {
    BottomPanelState mstate = BottomPanelState();
    mstate.useVideoSourceApi = state.useVideoSourceApi;
    mstate.streamInBrowser = state.streamInBrowser;
    mstate.selectEpisode = state.selectedEpisode.episodeNumber;
    mstate.userLiked = state.userliked ?? false;
    mstate.likeCount = state.likeCount ?? 0;
    mstate.streamLinks = state.streamLinks;
    mstate.commentCount = state.comments?.totalCount ?? 0;
    return mstate;
  }

  @override
  void set(EpisodeLiveStreamState state, BottomPanelState subState) {
    state.useVideoSourceApi = subState.useVideoSourceApi;
    state.streamInBrowser = subState.streamInBrowser;
  }
}
