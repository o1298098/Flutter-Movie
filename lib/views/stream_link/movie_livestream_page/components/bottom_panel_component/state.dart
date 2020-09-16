import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/views/stream_link/movie_livestream_page/state.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

import 'components/comment_component/state.dart';
import 'components/streamlink_filter_component/state.dart';

class BottomPanelState implements Cloneable<BottomPanelState> {
  String movieName;
  String preferHost;
  String defaultVideoLanguage;
  MovieStreamLinks streamLinks;
  MovieStreamLink selectedLink;
  CommentState commentState;
  StreamLinkFilterState streamLinkFilterState;
  GlobalKey<OverlayEntryManageState> overlayStateKey;
  bool useVideoSourceApi;
  bool streamInBrowser;
  bool userLiked;
  int likeCount;
  int movieId;
  int commentCount;
  @override
  BottomPanelState clone() {
    return BottomPanelState()
      ..movieName = movieName
      ..movieId = movieId
      ..userLiked = userLiked
      ..useVideoSourceApi = useVideoSourceApi
      ..streamInBrowser = streamInBrowser
      ..likeCount = likeCount
      ..streamLinks = streamLinks
      ..selectedLink = selectedLink
      ..commentCount = commentCount
      ..commentState = commentState
      ..streamLinkFilterState = streamLinkFilterState
      ..overlayStateKey = overlayStateKey
      ..preferHost = preferHost
      ..defaultVideoLanguage = defaultVideoLanguage;
  }
}

class BottomPanelConnector
    extends ConnOp<MovieLiveStreamState, BottomPanelState> {
  @override
  BottomPanelState get(MovieLiveStreamState state) {
    BottomPanelState mstate = state.bottomPanelState.clone();
    mstate.movieName = state.name;
    mstate.streamLinks = state.streamLinks;
    mstate.selectedLink = state.selectedLink;
    mstate.commentCount =
        state.bottomPanelState.commentState.comments?.totalCount ?? 0;
    return mstate;
  }

  @override
  void set(MovieLiveStreamState state, BottomPanelState subState) {
    state.bottomPanelState = subState;
    state.selectedLink = subState.selectedLink;
    state.streamLinks = subState.streamLinks;
  }
}
