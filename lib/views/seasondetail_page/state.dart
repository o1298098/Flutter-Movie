import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/seasondetail.dart';
import 'package:movie/models/videomodel.dart';

import 'components/episodes_component/state.dart';
import 'components/header_component/state.dart';
import 'components/seasoncast_component/state.dart';

class SeasonDetailPageState extends MutableSource
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

  @override
  Object getItemData(int index) {
    switch (index) {
      case 0:
        return HeaderState(
          name: tvShowName,
          seasonName: name,
          posterurl: seasonpic,
          airDate: seasonDetailModel.airDate,
          overwatch: seasonDetailModel.overview,
          seasonNumber: seasonNumber,
          videos: videos,
          images: images,
        );
      case 1:
        return seasonCastState;
      case 2:
        return EpisodesState(
          episodes: seasonDetailModel.episodes,
          tvid: tvid,
        );
      default:
        return null;
    }
  }

  @override
  String getItemType(int index) {
    switch (index) {
      case 0:
        return 'header';
      case 1:
        return 'seasonCast';
      case 2:
        return 'episodes';
      default:
        return null;
    }
  }

  @override
  int get itemCount => 3;

  @override
  void setItemData(int index, Object data) {}
}

SeasonDetailPageState initState(Map<String, dynamic> args) {
  SeasonDetailPageState state = SeasonDetailPageState();
  state.tvid = args['tvid'];
  state.tvShowName = args['tvShowName'];
  state.seasonNumber = args['seasonNumber'];
  state.name = args['seasonName'];
  state.seasonpic = args['posterpic'];
  state.seasonDetailModel = Season.fromParams(episodes: List<Episode>());
  state.seasonCastState = SeasonCastState();
  return state;
}
