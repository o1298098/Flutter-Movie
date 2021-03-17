import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/video_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<TvShowDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<TvShowDetailState>>{
      TvShowDetailAction.action: _onAction,
      TvShowDetailAction.init: _onInit,
      TvShowDetailAction.setCredits: _onCredits,
      TvShowDetailAction.setImages: _onSetImages,
      TvShowDetailAction.setReviews: _onSetReviews,
      TvShowDetailAction.setRecommendation: _onSetRecommendations,
      TvShowDetailAction.setKeyWords: _onSetKeyWords,
      TvShowDetailAction.setVideos: _onSetVideos,
      TvShowDetailAction.setAccountState: _onSetAccountState
    },
  );
}

TvShowDetailState _onAction(TvShowDetailState state, Action action) {
  final TvShowDetailState newState = state.clone();
  return newState;
}

TvShowDetailState _onInit(TvShowDetailState state, Action action) {
  TVDetailModel model = action.payload ?? new TVDetailModel.fromParams();
  final TvShowDetailState newState = state.clone();
  newState.tvDetailModel = model;
  return newState;
}

TvShowDetailState _onCredits(TvShowDetailState state, Action action) {
  CreditsModel c = action.payload;
  final TvShowDetailState newState = state.clone();
  newState.creditsModel = c;
  return newState;
}

TvShowDetailState _onSetImages(TvShowDetailState state, Action action) {
  ImageModel c = action.payload;
  final TvShowDetailState newState = state.clone();
  newState.imagesmodel = c;
  return newState;
}

TvShowDetailState _onSetReviews(TvShowDetailState state, Action action) {
  ReviewModel c = action.payload;
  final TvShowDetailState newState = state.clone();
  newState.reviewModel = c;
  return newState;
}

TvShowDetailState _onSetRecommendations(
    TvShowDetailState state, Action action) {
  VideoListModel c = action.payload;
  final TvShowDetailState newState = state.clone();
  newState.recommendations = c;
  return newState;
}

TvShowDetailState _onSetKeyWords(TvShowDetailState state, Action action) {
  KeyWordModel c = action.payload ??
      new KeyWordModel.fromParams(keywords: []);
  final TvShowDetailState newState = state.clone();
  newState.keywords = c;
  return newState;
}

TvShowDetailState _onSetVideos(TvShowDetailState state, Action action) {
  VideoModel c = action.payload;
  final TvShowDetailState newState = state.clone();
  newState.videomodel = c;
  return newState;
}

TvShowDetailState _onSetAccountState(TvShowDetailState state, Action action) {
  AccountState c = action.payload;
  final TvShowDetailState newState = state.clone();
  newState.accountState = c;
  return newState;
}
