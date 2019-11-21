import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie.dart';
import 'package:movie/models/base_api_model/base_tvshow.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomePageState>>{
      HomePageAction.action: _onAction,
      HomePageAction.initMovie: _onInitMovie,
      HomePageAction.initTV: _onInitTV,
      HomePageAction.initPopularMovies: _onInitPopularMovie,
      HomePageAction.initPopularTVShows: _onInitPopularTVShows,
      HomePageAction.popularFilterChanged: _onPopularFilterChanged,
      HomePageAction.headerFilterChanged: _onHeaderFilterChanged,
      HomePageAction.shareFilterChanged: _onShareFilterChanged,
      HomePageAction.initTrending: _onInitTrending,
      HomePageAction.initShareMovies: _onInitShareMovies,
      HomePageAction.initShareTvShows: _onInitShareTvShows,
    },
  );
}

HomePageState _onAction(HomePageState state, Action action) {
  final HomePageState newState = state.clone();
  return newState;
}

HomePageState _onInitShareMovies(HomePageState state, Action action) {
  final BaseMovieModel d = action.payload;
  final HomePageState newState = state.clone();
  newState.shareMovies = d;
  return newState;
}

HomePageState _onInitShareTvShows(HomePageState state, Action action) {
  final BaseTvShowModel d = action.payload;
  final HomePageState newState = state.clone();
  newState.shareTvshows = d;
  return newState;
}

HomePageState _onInitMovie(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.movie = model;
  return newState;
}

HomePageState _onInitTV(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.tv = model;
  return newState;
}

HomePageState _onInitPopularMovie(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.popularMovies = model;
  return newState;
}

HomePageState _onInitPopularTVShows(HomePageState state, Action action) {
  final VideoListModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.popularTVShows = model;
  return newState;
}

HomePageState _onInitTrending(HomePageState state, Action action) {
  final SearchResultModel model = action.payload ?? null;
  final HomePageState newState = state.clone();
  newState.trending = model;
  return newState;
}

HomePageState _onPopularFilterChanged(HomePageState state, Action action) {
  final bool e = action.payload ?? true;
  final HomePageState newState = state.clone();
  newState.showPopMovie = e;
  return newState;
}

HomePageState _onHeaderFilterChanged(HomePageState state, Action action) {
  final bool e = action.payload ?? true;
  final HomePageState newState = state.clone();
  newState.showHeaderMovie = e;
  return newState;
}

HomePageState _onShareFilterChanged(HomePageState state, Action action) {
  final bool e = action.payload ?? true;
  final HomePageState newState = state.clone();
  newState.showShareMovie = e;
  return newState;
}
