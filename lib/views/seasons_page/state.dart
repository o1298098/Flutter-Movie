import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/season_detail.dart';

class SeasonsPageState implements Cloneable<SeasonsPageState> {
  int tvid;
  List<Season> seasons;
  AnimationController animationController;

  @override
  SeasonsPageState clone() {
    return SeasonsPageState()..seasons = seasons;
  }
}

SeasonsPageState initState(Map<String, dynamic> args) {
  SeasonsPageState state = SeasonsPageState();
  state.seasons = args['list'] ?? [];
  state.tvid = args['tvid'];
  return state;
}
