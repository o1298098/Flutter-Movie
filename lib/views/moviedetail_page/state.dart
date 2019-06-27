import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetailPageState implements GlobalBaseState<MovieDetailPageState> {
  MovieDetailModel movieDetailModel;
  String backdropPic;
  int movieid;
  CreditsModel creditsModel;
  PaletteGenerator palette;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoListModel recommendations;
  KeyWordModel keywords;
  VideoModel videomodel;

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
      ..videomodel = videomodel
      ..backdropPic=backdropPic;
  }

  @override
  Color themeColor = Colors.black;
}

MovieDetailPageState initState(Map<String, dynamic> args) {
  var state = MovieDetailPageState();
  state.movieid = args['movieid'];
  if(args['bgpic']!=null)state.backdropPic = args['bgpic'];
  state.movieDetailModel = new MovieDetailModel.fromParams();
  state.creditsModel = new CreditsModel.fromParams(
      cast: List<CastData>(), crew: List<CrewData>());
  state.palette = new PaletteGenerator.fromColors(
      List<PaletteColor>()..add(new PaletteColor(Colors.black87, 0)));
  state.imagesmodel = new ImageModel.fromParams(
      posters: List<ImageData>(), backdrops: List<ImageData>());
  state.reviewModel = new ReviewModel.fromParams(results: List<ReviewResult>());
  state.recommendations =
      new VideoListModel.fromParams(results: List<VideoListResult>());
  state.keywords = new KeyWordModel.fromParams(keywords: List<KeyWordData>());
  state.videomodel = new VideoModel.fromParams(results: List<VideoResult>());
  return state;
}
