import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/media_accountstatemodel.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';
import 'package:palette_generator/palette_generator.dart';

//TODO replace with your own action
enum TVDetailPageAction {
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
  onImageCellTapped
}

class TVDetailPageActionCreator {
  static Action onAction() {
    return const Action(TVDetailPageAction.action);
  }

  static Action onInit(TVDetailModel model) {
    return Action(TVDetailPageAction.init, payload: model);
  }

  static Action onsetColor(PaletteGenerator c) {
    return Action(TVDetailPageAction.setbgcolor, payload: c);
  }

  static Action onCredits(CreditsModel c) {
    return Action(TVDetailPageAction.setCredits, payload: c);
  }

  static Action onSetImages(ImageModel c) {
    return Action(TVDetailPageAction.setImages, payload: c);
  }

  static Action onSetReviews(ReviewModel c) {
    return Action(TVDetailPageAction.setReviews, payload: c);
  }

  static Action onSetRecommendations(VideoListModel c) {
    return Action(TVDetailPageAction.setRecommendation, payload: c);
  }

  static Action onKeyWords(KeyWordModel c) {
    return Action(TVDetailPageAction.setKeyWords, payload: c);
  }

  static Action onSetVideos(VideoModel c) {
    return Action(TVDetailPageAction.setVideos, payload: c);
  }

  static Action onRecommendationTapped(int movieid, String backpic) {
    return Action(TVDetailPageAction.recommendationTapped,
        payload: [movieid, backpic]);
  }

  static Action onCastCellTapped(
      int peopleid, String profilePath, String profileName) {
    return Action(TVDetailPageAction.castCellTapped,
        payload: [peopleid, profilePath, profileName]);
  }

  static Action onSetAccountState(MediaAccountStateModel model) {
    return Action(TVDetailPageAction.setAccountState, payload: model);
  }

  static Action openMenu() {
    return Action(TVDetailPageAction.openMenu);
  }

  static Action showSnackBar(String message) {
    return Action(TVDetailPageAction.showSnackBar, payload: message);
  }

  static Action onImageCellTapped(int index, List<ImageData> data) {
    return Action(TVDetailPageAction.onImageCellTapped, payload: [index, data]);
  }
}
