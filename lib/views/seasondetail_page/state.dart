import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/models/video_model.dart';

import 'components/seasoncast_component/state.dart';

class SeasonDetailPageState
    implements GlobalBaseState, Cloneable<SeasonDetailPageState> {
  Season seasonDetailModel;
  SeasonCastState seasonCastState;
  VideoModel videos;
  ImageModel images;
  ScrollController scrollController;
  String tvShowName;
  String name;
  String seasonpic;
  int tvid;
  int seasonNumber;

  @override
  SeasonDetailPageState clone() {
    return SeasonDetailPageState()
      ..seasonDetailModel = seasonDetailModel
      ..tvid = tvid
      ..seasonNumber = seasonNumber
      ..seasonCastState = seasonCastState
      ..name = name
      ..images = images
      ..videos = videos
      ..tvShowName = tvShowName
      ..seasonpic = seasonpic
      ..scrollController = scrollController;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;
}

SeasonDetailPageState initState(Map<String, dynamic> args) {
  SeasonDetailPageState state = SeasonDetailPageState();
  state.tvid = args['tvid'];
  state.tvShowName = args['tvShowName'];
  state.seasonNumber = args['seasonNumber'];
  state.name = args['seasonName'];
  state.seasonpic = args['posterpic'];
  state.seasonDetailModel = Season.fromParams(episodes: []);
  state.seasonCastState = SeasonCastState();
  return state;
}
