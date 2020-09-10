import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/media_account_state_model.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/video_model.dart';
import 'package:palette_generator/palette_generator.dart';

enum MovieDetailPageAction {
  action,
  init,
  setbgcolor,
  setVideos,
  setImages,
  setReviews,
  setAccountState,
  recommendationTapped,
  castCellTapped,
  openMenu,
  showSnackBar
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

  static Action onSetImages(ImageModel c) {
    return Action(MovieDetailPageAction.setImages, payload: c);
  }

  static Action onSetReviews(ReviewModel c) {
    return Action(MovieDetailPageAction.setReviews, payload: c);
  }

  static Action onSetVideos(VideoModel c) {
    return Action(MovieDetailPageAction.setVideos, payload: c);
  }

  static Action onRecommendationTapped(int movieid, String backpic) {
    return Action(MovieDetailPageAction.recommendationTapped,
        payload: [movieid, backpic]);
  }

  static Action onCastCellTapped(
      int peopleid, String profilePath, String profileName) {
    return Action(MovieDetailPageAction.castCellTapped,
        payload: [peopleid, profilePath, profileName]);
  }

  static Action onSetAccountState(MediaAccountStateModel model) {
    return Action(MovieDetailPageAction.setAccountState, payload: model);
  }

  static Action openMenu() {
    return Action(MovieDetailPageAction.openMenu);
  }

  static Action showSnackBar(String message) {
    return Action(MovieDetailPageAction.showSnackBar, payload: message);
  }
}
