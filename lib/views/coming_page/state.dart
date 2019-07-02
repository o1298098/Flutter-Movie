import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/videolist.dart';

class ComingPageState implements Cloneable<ComingPageState> {
  
  VideoListModel moviecoming;
  VideoListModel tvcoming;
  ScrollController movieController;
  ScrollController tvController;
  bool showmovie;

  @override
  ComingPageState clone() {
    return ComingPageState()
    ..movieController=movieController
    ..tvController=tvController
    ..moviecoming=moviecoming
    ..tvcoming=tvcoming
    ..showmovie=showmovie;
  }
}

ComingPageState initState(Map<String, dynamic> args) {
  var state=ComingPageState();
  state.showmovie=true;
  state.moviecoming=VideoListModel.fromParams(results:List<VideoListResult>());
  state.tvcoming=VideoListModel.fromParams(results:List<VideoListResult>());
  return state;
}
