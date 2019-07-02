import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<ComingPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<ComingPageState>>{
      ComingPageAction.action: _onAction,
      ComingPageAction.initMoviesComing: _onInitMoviesComing,
      ComingPageAction.initTVComing: _onInitTVComing,
      ComingPageAction.loadMore: _onLoadMore,
      ComingPageAction.filterChanged:_onFilterChanged
    },
  );
}

ComingPageState _onAction(ComingPageState state, Action action) {
  final ComingPageState newState = state.clone();
  return newState;
}

ComingPageState _onInitMoviesComing(ComingPageState state, Action action) {
  final VideoListModel q = action.payload ??
      VideoListModel.fromParams(results: List<VideoListResult>());
  final ComingPageState newState = state.clone();
  newState.moviecoming = q;
  return newState;
}

ComingPageState _onLoadMore(ComingPageState state, Action action) {
  final VideoListModel q = action.payload ??
      VideoListModel.fromParams(results: List<VideoListResult>());
  final ComingPageState newState = state.clone();
  if (newState.showmovie) {
    newState.moviecoming.page = q.page;
    newState.moviecoming.results.addAll(q.results);
  }
  else{
     newState.tvcoming.page = q.page;
    newState.tvcoming.results.addAll(q.results);
  }
  return newState;
}

ComingPageState _onInitTVComing(ComingPageState state, Action action) {
  final VideoListModel q = action.payload ??
      VideoListModel.fromParams(results: List<VideoListResult>());
  final ComingPageState newState = state.clone();
  newState.tvcoming = q;
  return newState;
}

ComingPageState _onFilterChanged(ComingPageState state, Action action) {
  final bool b=action.payload??true;
  final ComingPageState newState = state.clone();
  newState.showmovie=b;
  return newState;
}
