import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/views/detail_page/state.dart';

class AppBarState implements Cloneable<AppBarState> {
  String title;
  ScrollController scrollController;
  @override
  AppBarState clone() {
    return AppBarState()
      ..title = title
      ..scrollController = scrollController;
  }
}

class AppBarConnector extends ConnOp<MovieDetailPageState, AppBarState> {
  @override
  AppBarState get(MovieDetailPageState state) {
    AppBarState substate = new AppBarState();
    substate.title = state.detail?.title;
    substate.scrollController = state.scrollController;
    return substate;
  }
}
