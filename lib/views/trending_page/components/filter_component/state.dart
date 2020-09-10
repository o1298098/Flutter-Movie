import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/sort_condition.dart';
import 'package:movie/views/trending_page/state.dart';

class FilterState implements Cloneable<FilterState> {
  AnimationController animationController;
  List<SortCondition> mediaTypes;

  AnimationController refreshController;
  MediaType selectMediaType;
  bool isToday;
  @override
  FilterState clone() {
    return FilterState()
      ..refreshController = refreshController
      ..animationController = animationController
      ..isToday = isToday
      ..mediaTypes = mediaTypes
      ..selectMediaType = selectMediaType;
  }
}

class FilterConnector extends ConnOp<TrendingPageState, FilterState> {
  @override
  FilterState get(TrendingPageState state) {
    FilterState mstate = FilterState();
    mstate.animationController = state.animationController;
    mstate.isToday = state.isToday;
    mstate.mediaTypes = state.mediaTypes;
    mstate.selectMediaType = state.selectMediaType;
    mstate.refreshController = state.refreshController;
    return mstate;
  }

  @override
  void set(TrendingPageState state, FilterState subState) {
    state.isToday = subState.isToday;
    state.mediaTypes = subState.mediaTypes;
    state.selectMediaType = subState.selectMediaType;
  }
}
