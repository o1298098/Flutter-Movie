import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/video_model.dart';

enum TvShowDetailAction {
  action,
  init,
  setbgcolor,
  setCredits,
  setVideos,
  setImages,
  setReviews,
  setRecommendation,
  setKeyWords,
  setAccountState,
  recommendationTapped,
  castCellTapped,
  openMenu,
  showSnackBar,
  onImageCellTapped,
  moreEpisode,
}

class TvShowDetailActionCreator {
  static Action onAction() {
    return const Action(TvShowDetailAction.action);
  }

  static Action onInit(TVDetailModel model) {
    return Action(TvShowDetailAction.init, payload: model);
  }

  static Action onCredits(CreditsModel c) {
    return Action(TvShowDetailAction.setCredits, payload: c);
  }

  static Action onSetImages(ImageModel c) {
    return Action(TvShowDetailAction.setImages, payload: c);
  }

  static Action onSetReviews(ReviewModel c) {
    return Action(TvShowDetailAction.setReviews, payload: c);
  }

  static Action onSetRecommendations(VideoListModel c) {
    return Action(TvShowDetailAction.setRecommendation, payload: c);
  }

  static Action onKeyWords(KeyWordModel c) {
    return Action(TvShowDetailAction.setKeyWords, payload: c);
  }

  static Action onSetVideos(VideoModel c) {
    return Action(TvShowDetailAction.setVideos, payload: c);
  }

  static Action onRecommendationTapped(int movieid, String backpic) {
    return Action(TvShowDetailAction.recommendationTapped,
        payload: [movieid, backpic]);
  }

  static Action onCastCellTapped(
      int peopleid, String profilePath, String profileName) {
    return Action(TvShowDetailAction.castCellTapped,
        payload: [peopleid, profilePath, profileName]);
  }

  static Action onSetAccountState(AccountState model) {
    return Action(TvShowDetailAction.setAccountState, payload: model);
  }

  static Action openMenu() {
    return Action(TvShowDetailAction.openMenu);
  }

  static Action showSnackBar(String message) {
    return Action(TvShowDetailAction.showSnackBar, payload: message);
  }

  static Action onImageCellTapped(int index, List<ImageData> data) {
    return Action(TvShowDetailAction.onImageCellTapped, payload: [index, data]);
  }

  static Action moreEpisode() {
    return Action(TvShowDetailAction.moreEpisode);
  }
}
