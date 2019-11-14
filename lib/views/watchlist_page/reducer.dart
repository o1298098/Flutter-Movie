import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<WatchlistPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<WatchlistPageState>>{
      WatchlistPageAction.action: _onAction,
      WatchlistPageAction.setTVShow: _setTVShow,
      WatchlistPageAction.widthChanged: _widthChanged,
      WatchlistPageAction.swiperChanged: _swiperChanged,
      WatchlistPageAction.setMovie: _setMovie,
    },
  );
}

WatchlistPageState _onAction(WatchlistPageState state, Action action) {
  final WatchlistPageState newState = state.clone();
  return newState;
}

WatchlistPageState _setTVShow(WatchlistPageState state, Action action) {
  final UserMediaModel model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.tvshows = model;
  return newState;
}

WatchlistPageState _widthChanged(WatchlistPageState state, Action action) {
  final bool isMovie = action.payload ?? false;
  final WatchlistPageState newState = state.clone();
  newState.isMovie = isMovie;
  if (isMovie && newState.movies?.data != null)
    newState.selectMdeia = newState.movies.data[0];
  else if (!isMovie && newState.tvshows?.data != null)
    newState.selectMdeia = newState.tvshows.data[0];
  else
    newState.selectMdeia = null;
  return newState;
}

WatchlistPageState _swiperChanged(WatchlistPageState state, Action action) {
  final UserMedia model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.selectMdeia = model;
  return newState;
}

WatchlistPageState _setMovie(WatchlistPageState state, Action action) {
  final UserMediaModel movie = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.movies = movie;
  if (movie.data.length > 0) newState.selectMdeia = movie.data[0];
  return newState;
}
