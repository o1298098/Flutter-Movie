import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/peopledetail_page/state.dart';

class TimeLineState implements Cloneable<TimeLineState> {
  String department;
  bool showmovie = true;
  List<CombinedCastData> movies;
  List<CombinedCastData> tvshows;
  ScrollPhysics scrollPhysics;

  TimeLineState(
      {this.department,
      this.showmovie,
      this.scrollPhysics,
      this.movies,
      this.tvshows});

  @override
  TimeLineState clone() {
    return TimeLineState()
      ..department = department
      ..showmovie = showmovie
      ..scrollPhysics = scrollPhysics
      ..movies = movies
      ..tvshows = tvshows;
  }
}

class TimeLineConnector extends ConnOp<PeopleDetailPageState, TimeLineState> {
  @override
  TimeLineState get(PeopleDetailPageState state) {
    TimeLineState mstate = TimeLineState();
    mstate.department = state.peopleDetailModel.knownForDepartment;
    mstate.showmovie = state.showmovie;
    mstate.scrollPhysics = state.pageScrollPhysics;
    mstate.movies = state.movies;
    mstate.tvshows = state.tvshows;
    return mstate;
  }

  @override
  void set(PeopleDetailPageState state, TimeLineState subState) {
    state.showmovie = subState.showmovie;
  }
}
