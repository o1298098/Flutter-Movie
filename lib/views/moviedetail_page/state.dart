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
  String title;
  String posterPic;
  int movieid;
  PaletteGenerator palette;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoModel videomodel;

  @override
  MovieDetailPageState clone() {
    return MovieDetailPageState()
      ..movieDetailModel = movieDetailModel
      ..palette = palette
      ..movieid = movieid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..videomodel = videomodel
      ..backdropPic=backdropPic
      ..posterPic=posterPic
      ..title=title;
  }

  @override
  Color themeColor = Colors.black;
}

MovieDetailPageState initState(Map<String, dynamic> args) {
  var state = MovieDetailPageState();
  state.movieid = args['movieid'];
  if(args['bgpic']!=null)state.backdropPic = args['bgpic'];
  if(args['posterpic']!=null)state.posterPic = args['posterpic'];
  if(args['title']!=null)state.title = args['title'];
  state.movieDetailModel = new MovieDetailModel.fromParams();
  state.palette = new PaletteGenerator.fromColors(
      List<PaletteColor>()..add(new PaletteColor(Colors.black87, 0)));
  state.imagesmodel = new ImageModel.fromParams(
      posters: List<ImageData>(), backdrops: List<ImageData>());
  state.reviewModel = new ReviewModel.fromParams(results: List<ReviewResult>());
  state.videomodel = new VideoModel.fromParams(results: List<VideoResult>());
  return state;
}
