import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<WatchlistPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<WatchlistPageState>>{
      WatchlistPageAction.action: _onAction,
      WatchlistPageAction.setTVShowSnapshot: _setTVShowSnapshot,
      WatchlistPageAction.widthChanged: _widthChanged,
      WatchlistPageAction.swiperChanged: _swiperChanged,
      WatchlistPageAction.setMovieSnapshot: _setMovieSnapshot,
    },
  );
}

WatchlistPageState _onAction(WatchlistPageState state, Action action) {
  final WatchlistPageState newState = state.clone();
  return newState;
}

WatchlistPageState _setTVShowSnapshot(WatchlistPageState state, Action action) {
  final QuerySnapshot model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.tvSnapshot = model;
  return newState;
}

WatchlistPageState _widthChanged(WatchlistPageState state, Action action) {
  final bool isMovie = action.payload ?? false;
  final WatchlistPageState newState = state.clone();
  newState.isMovie = isMovie;
  if (isMovie && newState.movieSnapshot?.documents != null)
    newState.selectMdeia = newState.movieSnapshot.documents[0];
  else if (!isMovie && newState.tvSnapshot?.documents != null)
    newState.selectMdeia = newState.tvSnapshot.documents[0];
  else
    newState.selectMdeia = null;
  return newState;
}

WatchlistPageState _swiperChanged(WatchlistPageState state, Action action) {
  final DocumentSnapshot model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.selectMdeia = model;
  return newState;
}

WatchlistPageState _setMovieSnapshot(WatchlistPageState state, Action action) {
  final QuerySnapshot movieSnapshot = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.movieSnapshot = movieSnapshot;
  if (movieSnapshot.documents.length > 0)
    newState.selectMdeia = movieSnapshot.documents[0];
  return newState;
}
