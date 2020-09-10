import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/views/stream_link/season_link_page/state.dart';

class AppBarState implements Cloneable<AppBarState> {
  String backdropPath;
  AnimationController animationController;
  @override
  AppBarState clone() {
    return AppBarState();
  }
}

class AppBarConnector extends ConnOp<SeasonLinkPageState, AppBarState> {
  @override
  AppBarState get(SeasonLinkPageState state) {
    AppBarState mstate = AppBarState();
    mstate.backdropPath = state.detail?.backdropPath;
    mstate.animationController = state.animationController;
    return mstate;
  }
}
