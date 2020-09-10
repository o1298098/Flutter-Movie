import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/views/stream_link/movie_livestream_page/state.dart';

class RecommendationState implements Cloneable<RecommendationState> {
  int movieId;
  String name;
  String background;
  String overview;
  MovieDetailModel detail;
  ScrollController controller;

  @override
  RecommendationState clone() {
    return RecommendationState()
      ..detail = detail
      ..movieId = movieId
      ..name = name
      ..background = background
      ..overview = overview
      ..controller = controller;
  }
}

class RecommendationConnector
    extends ConnOp<MovieLiveStreamState, RecommendationState> {
  @override
  RecommendationState get(MovieLiveStreamState state) {
    RecommendationState mstate = RecommendationState();
    mstate.detail = state.detail;
    mstate.movieId = state.movieId;
    mstate.background = state.background;
    mstate.name = state.name;
    mstate.overview = state.overview;
    mstate.controller = state.scrollController;
    return mstate;
  }

  @override
  void set(MovieLiveStreamState state, RecommendationState subState) {
    state.detail = subState.detail;
    state.name = subState.name;
    state.background = subState.background;
    state.movieId = subState.movieId;
    state.overview = subState.overview;
  }
}
