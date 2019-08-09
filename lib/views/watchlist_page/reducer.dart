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
      WatchlistPageAction.widthChanged: _widthChanged
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
  return newState;
}

WatchlistPageState _setTVShowList(WatchlistPageState state, Action action) {
  final VideoListModel model = action.payload;
  final WatchlistPageState newState = state.clone();
  newState.tvshowList = model;
  return newState;
}

WatchlistPageState _widthChanged(WatchlistPageState state, Action action) {
  final bool isList = action.payload ?? false;
  final WatchlistPageState newState = state.clone();
  newState.isList = isList;
  return newState;
}
