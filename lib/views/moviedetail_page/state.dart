import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/models/movielist.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetailPageState implements GlobalBaseState<MovieDetailPageState> {
  MovieDetailModel movieDetailModel = new MovieDetailModel.fromParams();
  int movieid;
  CreditsModel creditsModel = new CreditsModel.fromParams(
      cast: List<CastData>(), crew: List<CrewData>());
  PaletteGenerator palette = new PaletteGenerator.fromColors(
      List<PaletteColor>()..add(new PaletteColor(Colors.black87, 0)));
  ImageModel imagesmodel = new ImageModel.fromParams(
      posters: List<PosterData>(), backdrops: List<BackDropData>());
  ReviewModel reviewModel =
      new ReviewModel.fromParams(results: List<ReviewResult>());
  MoiveListModel recommendations =
      new MoiveListModel.fromParams(results: List<MovieListResult>());
  KeyWordModel keywords =
      new KeyWordModel.fromParams(keywords: List<KeyWordData>());
  VideoModel videomodel = new VideoModel.fromParams(results: List<VideoResult>());

  @override
  MovieDetailPageState clone() {
    return MovieDetailPageState()
      ..movieDetailModel = movieDetailModel
      ..palette = palette
      ..creditsModel = creditsModel
      ..movieid = movieid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..recommendations = recommendations
      ..keywords = keywords
      ..videomodel=videomodel;
  }

  @override
  Color themeColor = Colors.black;
}

MovieDetailPageState initState(Map<String, dynamic> args) {
  var state = MovieDetailPageState();
  state.movieid = args['movieid'];
  return state;
}
