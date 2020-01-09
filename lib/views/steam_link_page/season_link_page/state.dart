import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeasonLinkPageState implements Cloneable<SeasonLinkPageState> {
  TVDetailModel detial;
  ScrollController scrollController;
  TabController tabController;
  AnimationController animationController;
  SharedPreferences preferences;

  @override
  SeasonLinkPageState clone() {
    return SeasonLinkPageState()
      ..detial = detial
      ..scrollController = scrollController
      ..tabController = tabController
      ..animationController = animationController
      ..preferences = preferences;
  }
}

SeasonLinkPageState initState(Map<String, dynamic> args) {
  SeasonLinkPageState state = SeasonLinkPageState();
  state.detial = args['detail'];
  return state;
}
