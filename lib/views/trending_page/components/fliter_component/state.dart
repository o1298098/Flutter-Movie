import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/views/trending_page/state.dart';

class FliterState implements Cloneable<FliterState> {
  AnimationController animationController;
  List<SortCondition> mediaTypes;

  AnimationController refreshController;
  MediaType selectMediaType;
  bool isToday;
  @override
  FliterState clone() {
    return FliterState()
      ..refreshController = refreshController
      ..animationController = animationController
      ..isToday = isToday
      ..mediaTypes = mediaTypes
      ..selectMediaType = selectMediaType;
  }
}

class FliterConnector extends ConnOp<TrendingPageState, FliterState> {
  @override
  FliterState get(TrendingPageState state) {
    FliterState mstate = FliterState();
    mstate.animationController = state.animationController;
    mstate.isToday = state.isToday;
    mstate.mediaTypes = state.mediaTypes;
    mstate.selectMediaType = state.selectMediaType;
    mstate.refreshController = state.refreshController;
    return mstate;
  }

  @override
  void set(TrendingPageState state, FliterState subState) {
    state.isToday = subState.isToday;
    state.mediaTypes = subState.mediaTypes;
    state.selectMediaType = subState.selectMediaType;
  }
}
