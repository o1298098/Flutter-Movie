import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/models/video_list.dart';

import 'action.dart';
import 'state.dart';

Reducer<RecommendationState> buildReducer() {
  return asReducer(
    <Object, Reducer<RecommendationState>>{
      RecommendationAction.action: _onAction,
      RecommendationAction.setInfo: _setInfo,
      RecommendationAction.setDetail: _setDetail
    },
  );
}

RecommendationState _onAction(RecommendationState state, Action action) {
  final RecommendationState newState = state.clone();
  return newState;
}

RecommendationState _setInfo(RecommendationState state, Action action) {
  final VideoListResult _data = action.payload;
  final RecommendationState newState = state.clone();
  if (_data != null) {
    newState.movieId = _data.id;
    newState.name = _data.title;
    newState.background = _data.backdropPath;
    newState.overview = _data.overview;
  }
  return newState;
}

RecommendationState _setDetail(RecommendationState state, Action action) {
  final MovieDetailModel _data = action.payload;
  final RecommendationState newState = state.clone();
  if (_data != null) newState.detail = _data;
  return newState;
}
