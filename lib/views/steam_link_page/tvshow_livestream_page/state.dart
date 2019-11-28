import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvShowLiveStreamPageState
    implements GlobalBaseState, Cloneable<TvShowLiveStreamPageState> {
  GlobalKey<ScaffoldState> scaffold;
  int tvid;
  Season season;
  CrossFadeState isExpanded;
  int episodeNumber;
  TvShowStreamLinks streamLinks;
  String streamAddress;
  StreamLinkType streamLinkType;
  Episode selectedEpisode;
  TvShowComments comments;
  TextEditingController commentController;
  YoutubePlayerController youtubePlayerController;
  ScrollController episodelistController;
  ChewieController chewieController;
  TabController tabController;
  bool showBottom;
  List<VideoPlayerController> videoControllers;

  @override
  TvShowLiveStreamPageState clone() {
    return TvShowLiveStreamPageState()
      ..scaffold = scaffold
      ..tvid = tvid
      ..season = season
      ..episodeNumber = episodeNumber
      ..selectedEpisode = selectedEpisode
      ..streamLinks = streamLinks
      ..streamLinkType = streamLinkType
      ..comments = comments
      ..chewieController = chewieController
      ..youtubePlayerController = youtubePlayerController
      ..episodelistController = episodelistController
      ..commentController = commentController
      ..videoControllers = videoControllers
      ..tabController = tabController
      ..isExpanded = isExpanded
      ..showBottom = showBottom
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

TvShowLiveStreamPageState initState(Map<String, dynamic> args) {
  TvShowLiveStreamPageState state = TvShowLiveStreamPageState();
  Episode _episode = args['episode'];
  state.tvid = args['tvid'];
  state.season = args['season'];
  if (_episode != null) {
    state.episodeNumber = _episode.episode_number;
    state.selectedEpisode = _episode;
  }
  state.isExpanded = CrossFadeState.showFirst;
  state.scaffold = GlobalKey<ScaffoldState>();
  state.showBottom = false;
  return state;
}
