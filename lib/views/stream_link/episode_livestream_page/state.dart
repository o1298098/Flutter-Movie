import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/views/stream_link/episode_livestream_page/components/bottom_panel_component/components/comment_component/state.dart';
import 'package:movie/views/stream_link/episode_livestream_page/components/bottom_panel_component/state.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

import 'components/bottom_panel_component/components/streamlink_filter_component/state.dart';
import 'components/player_component/state.dart';

class EpisodeLiveStreamState implements Cloneable<EpisodeLiveStreamState> {
  int tvid;
  String tvName;
  bool loading;
  TvShowStreamLinks streamLinks;
  TvShowStreamLink selectedLink;
  Episode selectedEpisode;
  Season season;
  ScrollController scrollController;
  PlayerState playerState;
  BottomPanelState bottomPanelState;

  @override
  EpisodeLiveStreamState clone() {
    return EpisodeLiveStreamState()
      ..loading = loading
      ..tvid = tvid
      ..tvName = tvName
      ..season = season
      ..streamLinks = streamLinks
      ..selectedEpisode = selectedEpisode
      ..scrollController = scrollController
      ..playerState = playerState
      ..bottomPanelState = bottomPanelState
      ..selectedLink = selectedLink;
  }
}

EpisodeLiveStreamState initState(Map<String, dynamic> args) {
  EpisodeLiveStreamState state = EpisodeLiveStreamState();
  state.tvid = args['tvid'];
  state.tvName = args['tvName'];
  state.season = args['season'];
  state.selectedEpisode = args['selectedEpisode'];
  state.bottomPanelState = BottomPanelState()
    ..overlayStateKey = GlobalKey<OverlayEntryManageState>()
    ..tvId = state.tvid
    ..season = state.season.seasonNumber
    ..useVideoSourceApi = true
    ..streamInBrowser = false
    ..commentState = CommentState()
    ..streamLinkFilterState = StreamLinkFilterState(
        overlayStateKey: GlobalKey<OverlayEntryManageState>())
    ..likeCount = 0
    ..userLiked = false;
  state.playerState = PlayerState()
    ..background = state.selectedEpisode.stillPath;
  state.loading = true;
  return state;
}
