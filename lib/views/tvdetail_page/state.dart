import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

class TVDetailPageState implements GlobalBaseState<TVDetailPageState> {
  TVDetailModel tvDetailModel;
  int tvid;
  CreditsModel creditsModel;
  PaletteGenerator palette;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoListModel recommendations;
  KeyWordModel keywords;
  VideoModel videomodel;

  @override
  TVDetailPageState clone() {
    return TVDetailPageState()
      ..tvDetailModel = tvDetailModel
      ..palette = palette
      ..creditsModel = creditsModel
      ..tvid = tvid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..recommendations = recommendations
      ..keywords = keywords
      ..videomodel = videomodel;
  }

  @override
  Color themeColor;
}

TVDetailPageState initState(Map<String, dynamic> args) {
  var state = TVDetailPageState();
  state.tvid = args['tvid'];
  state.tvDetailModel = new TVDetailModel.fromParams();
  state.creditsModel = new CreditsModel.fromParams(
      cast: List<CastData>(), crew: List<CrewData>());
  state.palette = new PaletteGenerator.fromColors(
      List<PaletteColor>()..add(new PaletteColor(Colors.black87, 0)));
  state.imagesmodel = new ImageModel.fromParams(
      posters: List<ImageData>(), backdrops: List<ImageData>());
  state.reviewModel = new ReviewModel.fromParams(results: List<ReviewResult>());
  state.recommendations =
      new VideoListModel.fromParams(results: List<VideoListResult>());
  state.keywords = new KeyWordModel.fromParams(keywords: List<KeyWordData>(),results: List<KeyWordData>());
  state.videomodel = new VideoModel.fromParams(results: List<VideoResult>());
  return state;
}
