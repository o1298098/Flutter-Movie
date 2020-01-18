import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/views/watchlist_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  AnimationController animationController;
  bool isMovie;

  UserMedia selectMdeia;
  UserMediaModel movies;
  UserMediaModel tvshows;
  @override
  HeaderState clone() {
    return HeaderState()
      ..isMovie = isMovie
      ..selectMdeia = selectMdeia
      ..movies = movies
      ..tvshows = tvshows;
  }
}

class HeaderConnector extends ConnOp<WatchlistPageState, HeaderState> {
  @override
  HeaderState get(WatchlistPageState state) {
    final HeaderState mstate = HeaderState();
    mstate.animationController = state.animationController;
    mstate.isMovie = state.isMovie;
    mstate.movies = state.movies;
    mstate.tvshows = state.tvshows;
    return mstate;
  }

  @override
  void set(WatchlistPageState state, HeaderState subState) {
    state.selectMdeia = subState.selectMdeia;
    state.isMovie = subState.isMovie;
  }
}
