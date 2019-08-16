import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/moviedetail.dart';

class MovieDetailPageState implements Cloneable<MovieDetailPageState> {
  int mediaId;
  MovieDetailModel detail;
  ImageModel imagesmodel;
  AnimationController animationController;
  ScrollController scrollController;
  @override
  MovieDetailPageState clone() {
    return MovieDetailPageState()
      ..detail = detail
      ..mediaId = mediaId
      ..imagesmodel = imagesmodel
      ..animationController = animationController
      ..scrollController = scrollController;
  }
}

MovieDetailPageState initState(Map<String, dynamic> args) {
  MovieDetailPageState state = MovieDetailPageState();
  state.mediaId = args['id'];
  state.detail = MovieDetailModel.fromParams();
  state.imagesmodel = ImageModel.fromParams(backdrops: [], posters: []);
  return state;
}
