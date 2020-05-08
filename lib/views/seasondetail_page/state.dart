import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/seasondetail.dart';

import 'components/episodes_component/state.dart';
import 'components/header_component/state.dart';
import 'components/seasoncast_component/state.dart';
import 'components/seasoncrew_component/state.dart';

class SeasonDetailPageState extends MutableSource
    implements GlobalBaseState, Cloneable<SeasonDetailPageState> {
  SeasonDetailModel seasonDetailModel;
  SeasonCastState seasonCastState;
  ScrollController scrollController;
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
      ..seasonpic = seasonpic
      ..scrollController;
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
            name: name,
            posterurl: seasonpic,
            airDate: seasonDetailModel.airDate,
            overwatch: seasonDetailModel.overview,
            seasonNumber: seasonNumber);
      case 1:
        return seasonCastState;
      case 2:
        return SeasonCrewState();
      case 3:
        return EpisodesState(episodes: seasonDetailModel.episodes, tvid: tvid);
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
        return 'seasonCrew';
      case 3:
        return 'episodes';
      default:
        return null;
    }
  }

  @override
  int get itemCount => 4;

  @override
  void setItemData(int index, Object data) {}
}

SeasonDetailPageState initState(Map<String, dynamic> args) {
  SeasonDetailPageState state = SeasonDetailPageState();
  state.tvid = args['tvid'];
  state.seasonNumber = args['seasonNumber'];
  state.name = args['name'];
  state.seasonpic = args['posterpic'];
  state.seasonDetailModel =
      SeasonDetailModel.fromParams(episodes: List<Episode>());
  state.seasonCastState = SeasonCastState();
  return state;
}
