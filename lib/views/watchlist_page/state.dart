import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/models/videolist.dart';

class WatchlistPageState implements Cloneable<WatchlistPageState> {
  int accountId;
  AnimationController animationController;
  VideoListModel movieList;
  VideoListModel tvshowList;
  bool isList;

  @override
  WatchlistPageState clone() {
    return WatchlistPageState()
      ..accountId = accountId
      ..animationController = animationController
      ..movieList = movieList
      ..tvshowList = tvshowList
      ..isList = isList;
  }
}

WatchlistPageState initState(Map<String, dynamic> args) {
  WatchlistPageState state = WatchlistPageState();
  state.accountId = args['accountid'];
  state.isList = false;
  return state;
}
