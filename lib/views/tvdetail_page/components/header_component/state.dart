import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/views/tvdetail_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  TVDetailModel tvDetailModel;
  int tvid;
  String name;
  String posterPic;
  String backdropPic;
  Color mainColor;
  AnimationController animationController;
  @override
  HeaderState clone() {
    return HeaderState();
  }
}

class HeaderConnector extends ConnOp<TVDetailPageState, HeaderState> {
  @override
  HeaderState get(TVDetailPageState state) {
    HeaderState substate = new HeaderState();
    substate.tvid = state.tvid;
    substate.animationController = state.animationController;
    substate.backdropPic = state.backdropPic;
    substate.mainColor = state.mainColor;
    substate.name = state.name;
    substate.posterPic = state.posterPic;
    substate.tvDetailModel = state.tvDetailModel;
    return substate;
  }
}
