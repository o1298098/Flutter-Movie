import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/episodelist_component/state.dart';

class SeasonLinkPageState extends MutableSource
    implements Cloneable<SeasonLinkPageState> {
  TVDetailModel detail;
  ScrollController scrollController;
  TabController tabController;
  AnimationController animationController;
  SharedPreferences preferences;

  @override
  SeasonLinkPageState clone() {
    return SeasonLinkPageState()
      ..detail = detail
      ..scrollController = scrollController
      ..tabController = tabController
      ..animationController = animationController
      ..preferences = preferences;
  }

  @override
  Object getItemData(int index) {
    final _seasons = detail.seasons.reversed.toList();
    return EpisodeListState(
        episodes: _seasons[index].episodes,
        season: _seasons[index],
        preferences: preferences,
        tvid: detail.id,
        name: detail.name);
  }

  @override
  String getItemType(int index) => 'listview';

  @override
  int get itemCount => detail.seasons.length;

  @override
  void setItemData(int index, Object data) {
    int newindex = detail.seasons.length - index;
    final EpisodeListState _e = data;
    detail.seasons[newindex] = _e.season;
  }
}

SeasonLinkPageState initState(Map<String, dynamic> args) {
  SeasonLinkPageState state = SeasonLinkPageState();
  state.detail = args['detail'];
  return state;
}
