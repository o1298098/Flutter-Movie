import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_media.dart';

import 'action.dart';
import 'state.dart';

Reducer<WatchlistPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<WatchlistPageState>>{
      WatchlistPageAction.action: _onAction,
      WatchlistPageAction.setTVShow: _setTVShow,
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
