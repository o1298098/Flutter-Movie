import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<WatchlistPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<WatchlistPageState>>{
      WatchlistPageAction.action: _onAction,
      WatchlistPageAction.setMovieList: _setMovieList,
      WatchlistPageAction.setTVShowList: _setTVShowList,
      WatchlistPageAction.widthChanged: _widthChanged,
      WatchlistPageAction.swiperChanged: _swiperChanged,
    },
  );
}

WatchlistPageState _onAction(WatchlistPageState state, Action action) {
  final WatchlistPageState newState = state.clone();
  return newState;
}

WatchlistPageState _setMovieList(WatchlistPageState state, Action action) {
  final VideoListModel model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.movieList = model;
  if (model.results.length > 0) newState.selectMdeia = model.results[0];
  return newState;
}

WatchlistPageState _setTVShowList(WatchlistPageState state, Action action) {
  final VideoListModel model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.tvshowList = model;
  return newState;
}

WatchlistPageState _widthChanged(WatchlistPageState state, Action action) {
  final bool isMovie = action.payload ?? false;
  final WatchlistPageState newState = state.clone();
  newState.isMovie = isMovie;
  if (isMovie && newState.movieList.results.length > 0)
    newState.selectMdeia = newState.movieList.results[0];
  else if (!isMovie && newState.tvshowList.results.length > 0)
    newState.selectMdeia = newState.tvshowList.results[0];
  return newState;
}

WatchlistPageState _swiperChanged(WatchlistPageState state, Action action) {
  final VideoListResult model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.selectMdeia = model;
  return newState;
}
