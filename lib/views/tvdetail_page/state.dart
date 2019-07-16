import 'dart:math';

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
//import 'package:palette_generator/palette_generator.dart';

class TVDetailPageState implements GlobalBaseState<TVDetailPageState> {
  TVDetailModel tvDetailModel;
  int tvid;
  String name;
  String posterPic;
  CreditsModel creditsModel;
  //PaletteGenerator palette;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoListModel recommendations;
  KeyWordModel keywords;
  VideoModel videomodel;
  String backdropPic;
  Color mainColor;

  @override
  TVDetailPageState clone() {
    return TVDetailPageState()
      ..tvDetailModel = tvDetailModel
      //..palette = palette
      ..mainColor=mainColor
      ..creditsModel = creditsModel
      ..tvid = tvid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..recommendations = recommendations
      ..keywords = keywords
      ..videomodel = videomodel
      ..backdropPic=backdropPic
      ..posterPic=posterPic
      ..name=name;
  }

  @override
  Color themeColor;
}

TVDetailPageState initState(Map<String, dynamic> args) {
  Random random=new Random(DateTime.now().millisecondsSinceEpoch);
  var state = TVDetailPageState();
  state.tvid = args['tvid'];
  if(args['bgpic']!=null)state.backdropPic = args['bgpic'];
  if(args['posterpic']!=null)state.posterPic = args['posterpic'];
  if(args['name']!=null)state.name = args['name'];
  state.tvDetailModel = new TVDetailModel.fromParams();
  state.creditsModel = new CreditsModel.fromParams(
      cast: List<CastData>(), crew: List<CrewData>());
  state.mainColor=Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
  /*state.palette = new PaletteGenerator.fromColors(
      List<PaletteColor>()..add(new PaletteColor(Colors.black87, 0)));*/
  state.imagesmodel = new ImageModel.fromParams(
      posters: List<ImageData>(), backdrops: List<ImageData>());
  state.reviewModel = new ReviewModel.fromParams(results: List<ReviewResult>());
  state.recommendations =
      new VideoListModel.fromParams(results: List<VideoListResult>());
  state.keywords = new KeyWordModel.fromParams(keywords: List<KeyWordData>(),results: List<KeyWordData>());
  state.videomodel = new VideoModel.fromParams(results: List<VideoResult>());
  return state;
}
