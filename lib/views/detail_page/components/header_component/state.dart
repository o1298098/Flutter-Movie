import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/views/detail_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  String bgPic;
  MovieDetailModel detail;
  ScrollController scrollController;
  bool hasStreamLink;
  @override
  HeaderState clone() {
    return HeaderState();
  }
}

class HeaderConnector extends ConnOp<MovieDetailPageState, HeaderState> {
  @override
  HeaderState get(MovieDetailPageState state) {
    HeaderState substate = new HeaderState();
    substate.bgPic = state.bgPic;
    substate.detail = state.detail;
    substate.hasStreamLink = state.hasStreamLink;
    substate.scrollController = state.scrollController;
    return substate;
  }
}
