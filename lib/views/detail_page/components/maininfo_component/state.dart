import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/views/detail_page/state.dart';

class MainInfoState implements Cloneable<MainInfoState> {
  String bgPic;
  MovieDetailModel detail;
  ScrollController scrollController;
  bool hasStreamLink;
  @override
  MainInfoState clone() {
    return MainInfoState();
  }
}

class MainInfoConnector extends ConnOp<MovieDetailPageState, MainInfoState> {
  @override
  MainInfoState get(MovieDetailPageState state) {
    MainInfoState substate = MainInfoState();
    substate.bgPic = state.bgPic;
    substate.detail = state.detail;
    substate.hasStreamLink = state.hasStreamLink;
    substate.scrollController = state.scrollController;
    return substate;
  }
}
