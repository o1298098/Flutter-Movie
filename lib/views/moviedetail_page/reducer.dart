import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/media_account_state_model.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/video_model.dart';
import 'package:palette_generator/palette_generator.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieDetailPageState>>{
      MovieDetailPageAction.action: _onAction,
      MovieDetailPageAction.init: _onInit,
      MovieDetailPageAction.setbgcolor: _onSetColor,
      MovieDetailPageAction.setImages: _onSetImages,
      MovieDetailPageAction.setReviews: _onSetReviews,
      MovieDetailPageAction.setVideos: _onSetVideos,
      MovieDetailPageAction.setAccountState: _onSetAccountState
    },
  );
}

MovieDetailPageState _onAction(MovieDetailPageState state, Action action) {
  final MovieDetailPageState newState = state.clone();
  return newState;
}

MovieDetailPageState _onInit(MovieDetailPageState state, Action action) {
  MovieDetailModel model = action.payload ?? new MovieDetailModel.fromParams();
  final MovieDetailPageState newState = state.clone();
  newState.movieDetailModel = model;
  newState.backdropPic = model.backdropPath;
  newState.posterPic = model.posterPath;
  newState.title = model.title;
  return newState;
}

MovieDetailPageState _onSetColor(MovieDetailPageState state, Action action) {
  PaletteGenerator c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.palette = c;
  return newState;
}

MovieDetailPageState _onSetImages(MovieDetailPageState state, Action action) {
  ImageModel c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.imagesmodel = c;
  return newState;
}

MovieDetailPageState _onSetReviews(MovieDetailPageState state, Action action) {
  ReviewModel c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.reviewModel = c;
  return newState;
}

MovieDetailPageState _onSetVideos(MovieDetailPageState state, Action action) {
  VideoModel c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.videomodel = c;
  return newState;
}

MovieDetailPageState _onSetAccountState(
    MovieDetailPageState state, Action action) {
  MediaAccountStateModel c = action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.accountState = c;
  return newState;
}
