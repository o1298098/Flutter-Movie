import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/moviedetail.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieDetailPageState>>{
      MovieDetailPageAction.action: _onAction,
      MovieDetailPageAction.updateDetail: _updateDetail,
      MovieDetailPageAction.setImages: _onSetImages,
    },
  );
}

MovieDetailPageState _onAction(MovieDetailPageState state, Action action) {
  final MovieDetailPageState newState = state.clone();
  return newState;
}

MovieDetailPageState _updateDetail(MovieDetailPageState state, Action action) {
  final MovieDetailModel model = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.detail = model;
  return newState;
}

MovieDetailPageState _onSetImages(MovieDetailPageState state, Action action) {
  ImageModel c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.imagesmodel = c;
  return newState;
}
