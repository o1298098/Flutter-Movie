import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/combinedcredits.dart';

class TimeLineState implements Cloneable<TimeLineState> {
  String department;
  CombinedCreditsModel creditsModel;
  bool showmovie = true;
  PageScrollPhysics scrollPhysics;

  TimeLineState(
      {this.department, this.creditsModel, this.showmovie, this.scrollPhysics});

  @override
  TimeLineState clone() {
    return TimeLineState()
      ..creditsModel = creditsModel
      ..department = department
      ..showmovie = showmovie
      ..scrollPhysics = scrollPhysics;
  }
}

TimeLineState initState(Map<String, dynamic> args) {
  return TimeLineState();
}
