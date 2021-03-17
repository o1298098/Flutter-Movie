import 'dart:math';
import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/media_account_state_model.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/video_model.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetailPageState
    implements GlobalBaseState, Cloneable<MovieDetailPageState> {
  GlobalKey<ScaffoldState> scaffoldkey;
  MovieDetailModel movieDetailModel;
  String backdropPic;
  String title;
  String posterPic;
  int movieid;
  Color mainColor;
  Color tabTintColor;
  PaletteGenerator palette;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoModel videomodel;
  ScrollController scrollController;
  MediaAccountStateModel accountState;
  AnimationController animationController;

  @override
  MovieDetailPageState clone() {
    return MovieDetailPageState()
      ..scaffoldkey = scaffoldkey
      ..movieDetailModel = movieDetailModel
      ..mainColor = mainColor
      ..tabTintColor = tabTintColor
      ..palette = palette
      ..movieid = movieid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..videomodel = videomodel
      ..backdropPic = backdropPic
      ..posterPic = posterPic
      ..title = title
      ..scrollController = scrollController
      ..accountState = accountState
      ..animationController = animationController;
  }

  @override
  Color themeColor = Colors.black;

  @override
  Locale locale;

  @override
  AppUser user;
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
  state.tabTintColor = Color.fromRGBO(
      random.nextInt(200), random.nextInt(100), random.nextInt(255), 1);
  state.palette = new PaletteGenerator.fromColors(
      []..add(new PaletteColor(Colors.black87, 0)));
  state.imagesmodel = new ImageModel.fromParams(
      posters: [], backdrops:[]);
  state.reviewModel = new ReviewModel.fromParams(results:[]);
  state.videomodel = new VideoModel.fromParams(results: []);
  state.accountState =
      new MediaAccountStateModel.fromParams(favorite: false, watchlist: false);
  return state;
}
