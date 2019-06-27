import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

//TODO replace with your own action
enum MovieDetailPageAction {
  action,
  init,
  setbgcolor,
  setCredits,
  setVideos,
  setImages,
  setReviews,
  setRecommendation,
  setKeyWords,
  recommendationTapped,
  castCellTapped,
}

class MovieDetailPageActionCreator {
  static Action onAction() {
    return const Action(MovieDetailPageAction.action);
  }

  static Action onInit(MovieDetailModel model) {
    return Action(MovieDetailPageAction.init, payload: model);
  }

  static Action onsetColor(PaletteGenerator c) {
    return Action(MovieDetailPageAction.setbgcolor, payload: c);
  }

  static Action onCredits(CreditsModel c) {
    return Action(MovieDetailPageAction.setCredits, payload: c);
  }

  static Action onSetImages(ImageModel c) {
    return Action(MovieDetailPageAction.setImages, payload: c);
  }

  static Action onSetReviews(ReviewModel c) {
    return Action(MovieDetailPageAction.setReviews, payload: c);
  }
  static Action onSetRecommendations(VideoListModel c) {
    return Action(MovieDetailPageAction.setRecommendation, payload: c);
  }
  static Action onKeyWords(KeyWordModel c) {
    return Action(MovieDetailPageAction.setKeyWords, payload: c);
  }
  static Action onSetVideos(VideoModel c) {
    return Action(MovieDetailPageAction.setVideos, payload: c);
  }
  static Action onRecommendationTapped(int movieid,String backpic) {
    return Action(MovieDetailPageAction.recommendationTapped, payload:[movieid,backpic]);
  }
  static Action onCastCellTapped(int peopleid,String profilePath,String profileName) {
    return Action(MovieDetailPageAction.castCellTapped, payload:[peopleid,profilePath,profileName]);
  }
  
}
