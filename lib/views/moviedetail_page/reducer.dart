import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

import 'action.dart';
import 'state.dart';

Reducer<MovieDetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieDetailPageState>>{
      MovieDetailPageAction.action: _onAction,
      MovieDetailPageAction.init:_onInit,
      MovieDetailPageAction.setbgcolor:_onSetColor,
      MovieDetailPageAction.setCredits:_onCredits,
      MovieDetailPageAction.setImages:_onSetImages,
      MovieDetailPageAction.setReviews:_onSetReviews,
      MovieDetailPageAction.setRecommendation:_onSetRecommendations,
      MovieDetailPageAction.setKeyWords:_onSetKeyWords,
      MovieDetailPageAction.setVideos:_onSetVideos,
    },
  );
}

MovieDetailPageState _onAction(MovieDetailPageState state, Action action) {
  final MovieDetailPageState newState = state.clone();
  return newState;
}
MovieDetailPageState _onInit(MovieDetailPageState state, Action action) {
  MovieDetailModel model=action.payload??new MovieDetailModel.fromParams();
  final MovieDetailPageState newState = state.clone();
  newState.movieDetailModel=model;
  newState.backdropPic=model.backdrop_path;
  return newState;
}
MovieDetailPageState _onSetColor(MovieDetailPageState state, Action action) {
  PaletteGenerator c=action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.palette=c;
  return newState;
}
MovieDetailPageState _onCredits(MovieDetailPageState state, Action action) {
  CreditsModel c=action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.creditsModel=c;
  return newState;
}
MovieDetailPageState _onSetImages(MovieDetailPageState state, Action action) {
  ImageModel c=action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.imagesmodel=c;
  return newState;
}
MovieDetailPageState _onSetReviews(MovieDetailPageState state, Action action) {
  ReviewModel c=action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.reviewModel=c;
  return newState;
}
MovieDetailPageState _onSetRecommendations(MovieDetailPageState state, Action action) {
  VideoListModel c=action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.recommendations=c;
  return newState;
}
MovieDetailPageState _onSetKeyWords(MovieDetailPageState state, Action action) {
  KeyWordModel c=action.payload?? new KeyWordModel.fromParams(keywords: List<KeyWordData>());
  final MovieDetailPageState newState = state.clone();
  newState.keywords=c;
  return newState;
}
MovieDetailPageState _onSetVideos(MovieDetailPageState state, Action action) {
  VideoModel c=action.payload;
  final MovieDetailPageState newState = state.clone();
  newState.videomodel=c;
  return newState;
}
