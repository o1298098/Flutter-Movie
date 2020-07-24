import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/views/stream_link_page/episode_livestream_page/state.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

import 'components/comment_component/state.dart';

class BottomPanelState implements Cloneable<BottomPanelState> {
  TvShowStreamLinks streamLinks;
  TvShowStreamLink selectedLink;
  CommentState commentState;
  bool useVideoSourceApi;
  bool streamInBrowser;
  bool userLiked;
  int likeCount;
  int tvId;
  int season;
  int commentCount;
  int selectEpisode;
  GlobalKey<OverlayEntryManageState> overlayStateKey;

  @override
  BottomPanelState clone() {
    return BottomPanelState()
      ..tvId = tvId
      ..season = season
      ..userLiked = userLiked
      ..useVideoSourceApi = useVideoSourceApi
      ..streamInBrowser = streamInBrowser
      ..likeCount = likeCount
      ..streamLinks = streamLinks
      ..selectedLink = selectedLink
      ..commentCount = commentCount
      ..selectEpisode = selectEpisode
      ..commentState = commentState
      ..overlayStateKey = overlayStateKey;
  }
}

class BottomPanelConnector
    extends ConnOp<EpisodeLiveStreamState, BottomPanelState> {
  @override
  BottomPanelState get(EpisodeLiveStreamState state) {
    BottomPanelState mstate = state.bottomPanelState.clone();
    mstate.selectEpisode = state.selectedEpisode.episodeNumber;
    mstate.streamLinks = state.streamLinks;
    mstate.selectedLink = state.selectedLink;
    mstate.commentCount =
        state.bottomPanelState.commentState.comments?.totalCount ?? 0;
    return mstate;
  }

  @override
  void set(EpisodeLiveStreamState state, BottomPanelState subState) {
    state.bottomPanelState = subState;
    state.selectedLink = subState.selectedLink;
  }
}
