import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/models/videolist.dart';

class WatchlistPageState implements Cloneable<WatchlistPageState> {
  int accountId;
  AnimationController animationController;
  VideoListModel movieList;
  VideoListModel tvshowList;
  VideoListResult selectMdeia;
  bool isMovie;
  SwiperController swiperController;

  @override
  WatchlistPageState clone() {
    return WatchlistPageState()
      ..accountId = accountId
      ..animationController = animationController
      ..movieList = movieList
      ..tvshowList = tvshowList
      ..selectMdeia = selectMdeia
      ..swiperController = swiperController
      ..isMovie = isMovie;
  }
}

WatchlistPageState initState(Map<String, dynamic> args) {
  WatchlistPageState state = WatchlistPageState();
  state.accountId = args['accountid'];
  state.isMovie = true;
  return state;
}
