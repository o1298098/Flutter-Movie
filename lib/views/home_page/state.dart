import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/videolist.dart';

class HomePageState implements Cloneable<HomePageState> {

VideoListModel movie;
VideoListModel tv;
VideoListModel popularMovies;
VideoListModel popularTVShows;
ScrollController scrollController;
bool showmovie;
  @override
  HomePageState clone() {
    return HomePageState()
    ..tv=tv
    ..movie=movie
    ..popularMovies=popularMovies
    ..popularTVShows=popularTVShows
    ..showmovie=showmovie
    ..scrollController=scrollController;
  }
}
HomePageState initState(Map<String, dynamic> args) {
  var state=HomePageState();
  state.movie=new VideoListModel.fromParams(results: List<VideoListResult>());
  state.tv=new VideoListModel.fromParams(results: List<VideoListResult>());
  state.popularMovies=new VideoListModel.fromParams(results: List<VideoListResult>());
  state.popularTVShows=new VideoListModel.fromParams(results: List<VideoListResult>());
  state.showmovie=true;
  return state;
}
