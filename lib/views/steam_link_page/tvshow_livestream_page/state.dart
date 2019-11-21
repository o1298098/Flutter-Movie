import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvShowLiveStreamPageState
    implements GlobalBaseState, Cloneable<TvShowLiveStreamPageState> {
  int tvid;
  int season;
  int selectedEpisode;
  TvShowStreamLinks streamLinks;
  String streamAddress;
  ChewieController chewieController;
  StreamLinkType streamLinkType;
  YoutubePlayerController youtubePlayerController;
  ScrollController episodelistController;

  @override
  TvShowLiveStreamPageState clone() {
    return TvShowLiveStreamPageState()
      ..tvid = tvid
      ..season = season
      ..selectedEpisode = selectedEpisode
      ..streamLinks = streamLinks
      ..youtubePlayerController = youtubePlayerController
      ..episodelistController = episodelistController;
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
  state.tvid = args['tvid'];
  state.season = args['season'];
  state.selectedEpisode = args['episode'];
  return state;
}
