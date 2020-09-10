import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie.dart';
import 'package:movie/models/base_api_model/base_tvshow.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllStreamLinkPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllStreamLinkPageState>>{
      AllStreamLinkPageAction.action: _onAction,
      AllStreamLinkPageAction.initMovieList: _initMovieList,
      AllStreamLinkPageAction.loadMoreMovies: _loadMoreMovies,
      AllStreamLinkPageAction.initTvShowList: _initTvShowList,
      AllStreamLinkPageAction.loadMoreTvShows: _loadMoreTvShows,
    },
  );
}

AllStreamLinkPageState _onAction(AllStreamLinkPageState state, Action action) {
  final AllStreamLinkPageState newState = state.clone();
  return newState;
}

AllStreamLinkPageState _loadMoreMovies(
    AllStreamLinkPageState state, Action action) {
  final BaseMovieModel _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  if (_list != null) {
    newState.movieList.page = _list.page;
    newState.movieList.data.addAll(_list?.data ?? []);
  }
  return newState;
}

AllStreamLinkPageState _loadMoreTvShows(
    AllStreamLinkPageState state, Action action) {
  final BaseTvShowModel _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  if (_list != null) {
    newState.tvList.page = _list.page;
    newState.tvList.data.addAll(_list?.data ?? []);
  }
  return newState;
}

AllStreamLinkPageState _initMovieList(
    AllStreamLinkPageState state, Action action) {
  final BaseMovieModel _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  newState.movieList = _list;
  return newState;
}

AllStreamLinkPageState _initTvShowList(
    AllStreamLinkPageState state, Action action) {
  final BaseTvShowModel _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  newState.tvList = _list;
  return newState;
}
