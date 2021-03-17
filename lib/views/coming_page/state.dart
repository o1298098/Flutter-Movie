import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/video_list.dart';

class ComingPageState implements Cloneable<ComingPageState> {
  VideoListModel moviecoming;
  VideoListModel tvcoming;
  ScrollController movieController;
  ScrollController tvController;
  bool showmovie;
  int moviePage;
  int tvPage;

  @override
  ComingPageState clone() {
    return ComingPageState()
      ..movieController = movieController
      ..tvController = tvController
      ..moviecoming = moviecoming
      ..tvcoming = tvcoming
      ..showmovie = showmovie
      ..moviePage = moviePage
      ..tvPage = tvPage;
  }
}

ComingPageState initState(Map<String, dynamic> args) {
  var state = ComingPageState();
  state.showmovie = true;
  state.moviecoming =
      VideoListModel.fromParams(results: []);
  state.tvcoming = VideoListModel.fromParams(results: []);
  return state;
}
