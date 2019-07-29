import 'dart:math';
import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/media_accountstatemodel.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetailPageState implements GlobalBaseState<MovieDetailPageState> {
  GlobalKey<ScaffoldState> scaffoldkey;
  MovieDetailModel movieDetailModel;
  String backdropPic;
  String title;
  String posterPic;
  int movieid;
  Color mainColor;
  PaletteGenerator palette;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoModel videomodel;
  ScrollController scrollController;
  MediaAccountStateModel accountState;

  @override
  MovieDetailPageState clone() {
    return MovieDetailPageState()
      ..scaffoldkey = scaffoldkey
      ..movieDetailModel = movieDetailModel
      ..mainColor = mainColor
      ..palette = palette
      ..movieid = movieid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..videomodel = videomodel
      ..backdropPic = backdropPic
      ..posterPic = posterPic
      ..title = title
      ..scrollController = scrollController
      ..accountState = accountState;
  }

  @override
  Color themeColor = Colors.black;
}

MovieDetailPageState initState(Map<String, dynamic> args) {
  Random random = new Random(DateTime.now().millisecondsSinceEpoch);
  var state = MovieDetailPageState();
  state.scaffoldkey = GlobalKey<ScaffoldState>();
  state.movieid = args['movieid'];
  if (args['bgpic'] != null) state.backdropPic = args['bgpic'];
  if (args['posterpic'] != null) state.posterPic = args['posterpic'];
  if (args['title'] != null) state.title = args['title'];
  state.movieDetailModel = new MovieDetailModel.fromParams();
  state.mainColor = Color.fromRGBO(
      random.nextInt(200), random.nextInt(100), random.nextInt(255), 1);
  state.palette = new PaletteGenerator.fromColors(
      List<PaletteColor>()..add(new PaletteColor(Colors.black87, 0)));
  state.imagesmodel = new ImageModel.fromParams(
      posters: List<ImageData>(), backdrops: List<ImageData>());
  state.reviewModel = new ReviewModel.fromParams(results: List<ReviewResult>());
  state.videomodel = new VideoModel.fromParams(results: List<VideoResult>());
  state.accountState =
      new MediaAccountStateModel.fromParams(favorite: false, watchlist: false);
  return state;
}
