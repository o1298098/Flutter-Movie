import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/models/videolist.dart';

class HomePageState implements Cloneable<HomePageState> {
  VideoListModel movie;
  VideoListModel tv;
  VideoListModel popularMovies;
  VideoListModel popularTVShows;
  SearchResultModel trending;
  ScrollController scrollController;
  bool showHeaderMovie;
  bool showPopMovie;
  AnimationController animatedController;

  @override
  HomePageState clone() {
    return HomePageState()
      ..tv = tv
      ..movie = movie
      ..popularMovies = popularMovies
      ..popularTVShows = popularTVShows
      ..showHeaderMovie = showHeaderMovie
      ..showPopMovie = showPopMovie
      ..trending = trending
      ..scrollController = scrollController
      ..animatedController = animatedController;
  }
}

HomePageState initState(Map<String, dynamic> args) {
  var state = HomePageState();
  state.movie = new VideoListModel.fromParams(results: List<VideoListResult>());
  state.tv = new VideoListModel.fromParams(results: List<VideoListResult>());
  state.popularMovies =
      new VideoListModel.fromParams(results: List<VideoListResult>());
  state.popularTVShows =
      new VideoListModel.fromParams(results: List<VideoListResult>());
  state.trending = SearchResultModel.fromParams(results: []);
  state.showPopMovie = true;
  state.showHeaderMovie = true;
  return state;
}
