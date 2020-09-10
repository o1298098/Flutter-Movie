import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/views/favorites_page/state.dart';

class SwiperState implements Cloneable<SwiperState> {
  AnimationController animationController;
  bool isMovie;
  UserMediaModel movies;
  UserMediaModel tvshows;

  UserMedia selectedMedia;
  @override
  SwiperState clone() {
    return SwiperState()
      ..isMovie = isMovie
      ..movies = movies
      ..tvshows = tvshows
      ..selectedMedia = selectedMedia
      ..animationController = animationController;
  }
}

class SwiperConnector extends ConnOp<FavoritesPageState, SwiperState> {
  @override
  SwiperState get(FavoritesPageState state) {
    final SwiperState mstate = SwiperState();
    mstate.animationController = state.animationController;
    mstate.isMovie = state.isMovie;
    mstate.movies = state.movies;
    mstate.tvshows = state.tvshows;
    mstate.selectedMedia = state.selectedMedia;
    return mstate;
  }

  @override
  void set(FavoritesPageState state, SwiperState subState) {
    state.isMovie = subState.isMovie;
    state.selectedMedia = subState.selectedMedia;
  }
}
