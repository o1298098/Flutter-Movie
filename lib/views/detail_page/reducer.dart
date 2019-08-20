import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/media_accountstatemodel.dart';
import 'package:movie/models/moviedetail.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieDetailPageState>>{
      MovieDetailPageAction.action: _onAction,
      MovieDetailPageAction.updateDetail: _updateDetail,
      MovieDetailPageAction.setImages: _onSetImages,
      MovieDetailPageAction.setAccountState: _onSetAccountState
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
  if (newState.bgPic == null) newState.bgPic = model.poster_path;
  return newState;
}

MovieDetailPageState _onSetImages(MovieDetailPageState state, Action action) {
  ImageModel c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.imagesmodel = c;
  return newState;
}

MovieDetailPageState _onSetAccountState(
    MovieDetailPageState state, Action action) {
  MediaAccountStateModel c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.accountState = c;
  return newState;
}
