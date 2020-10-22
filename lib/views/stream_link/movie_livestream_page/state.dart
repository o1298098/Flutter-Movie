import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/views/stream_link/movie_livestream_page/components/bottom_panel_component/components/streamlink_filter_component/state.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

import 'components/bottom_panel_component/components/comment_component/state.dart';
import 'components/bottom_panel_component/state.dart';
import 'components/player_component/state.dart';

class MovieLiveStreamState
    implements GlobalBaseState, Cloneable<MovieLiveStreamState> {
  int movieId;
  String name;
  String background;
  String overview;
  bool loading;
  MovieDetailModel detail;
  MovieStreamLinks streamLinks;
  MovieStreamLink selectedLink;
  ScrollController scrollController;
  PlayerState playerState;
  BottomPanelState bottomPanelState;
  @override
  MovieLiveStreamState clone() {
    return MovieLiveStreamState()
      ..movieId = movieId
      ..name = name
      ..overview = overview
      ..background = background
      ..loading = loading
      ..detail = detail
      ..streamLinks = streamLinks
      ..selectedLink = selectedLink
      ..scrollController = scrollController
      ..playerState = playerState
      ..bottomPanelState = bottomPanelState
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  AppUser user;
}

MovieLiveStreamState initState(Map<String, dynamic> args) {
  MovieLiveStreamState state = MovieLiveStreamState();
  state.detail = args['detail'];
  if (state.detail != null) {
    state.movieId = state.detail.id;
    state.name = state.detail.title;
    state.overview = state.detail.overview;
    state.background = state.detail.backdropPath;
  }
  state.bottomPanelState = BottomPanelState()
    ..overlayStateKey = GlobalKey<OverlayEntryManageState>()
    ..movieId = state.movieId
    ..useVideoSourceApi = true
    ..streamInBrowser = false
    ..commentState = CommentState()
    ..streamLinkFilterState = StreamLinkFilterState(
        overlayStateKey: GlobalKey<OverlayEntryManageState>())
    ..likeCount = 0
    ..userLiked = false;
  state.playerState = PlayerState()..background = state.background;
  state.loading = true;
  return state;
}
