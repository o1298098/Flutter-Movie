import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/movie_detail.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieDetailPageState>>{
      MovieDetailPageAction.action: _onAction,
      MovieDetailPageAction.updateDetail: _updateDetail,
      MovieDetailPageAction.setImages: _onSetImages,
      MovieDetailPageAction.setAccountState: _onSetAccountState,
      MovieDetailPageAction.setHasStreamLink: _setHasStreamLink,
    },
  );
}

MovieDetailPageState _onAction(MovieDetailPageState state, Action action) {
  final MovieDetailPageState newState = state.clone();
  return newState;
}

MovieDetailPageState _setHasStreamLink(
    MovieDetailPageState state, Action action) {
  final bool b = action.payload ?? false;
  final MovieDetailPageState newState = state.clone();
  newState.hasStreamLink = b;
  return newState;
}

MovieDetailPageState _updateDetail(MovieDetailPageState state, Action action) {
  final MovieDetailModel model = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.detail = model;
  newState.hasStreamLink = true;
  if (newState.bgPic == null) newState.bgPic = model.posterPath;
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
  AccountState c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.accountState = c;
  return newState;
}
