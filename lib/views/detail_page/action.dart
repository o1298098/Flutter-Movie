import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/media_accountstatemodel.dart';
import 'package:movie/models/moviedetail.dart';

//TODO replace with your own action
enum MovieDetailPageAction {
  action,
  updateDetail,
  setImages,
  playTrailer,
  externalTapped,
  stillImageTapped,
  movieCellTapped,
  castCellTapped,
  setAccountState,
  openMenu,
  showSnackBar
}

class MovieDetailPageActionCreator {
  static Action onAction() {
    return const Action(MovieDetailPageAction.action);
  }

  static Action updateDetail(MovieDetailModel d) {
    return Action(MovieDetailPageAction.updateDetail, payload: d);
  }

  static Action onSetImages(ImageModel c) {
    return Action(MovieDetailPageAction.setImages, payload: c);
  }

  static Action playTrailer() {
    return const Action(MovieDetailPageAction.playTrailer);
  }

  static Action onExternalTapped(String url) {
    return Action(MovieDetailPageAction.externalTapped, payload: url);
  }

  static Action stillImageTapped(int index) {
    return Action(MovieDetailPageAction.stillImageTapped, payload: index);
  }

  static Action movieCellTapped(int id, String bgurl) {
    return Action(MovieDetailPageAction.movieCellTapped, payload: [id, bgurl]);
  }

  static Action castCellTapped(
      int id, String profilePath, String profileName, String character) {
    return Action(MovieDetailPageAction.castCellTapped,
        payload: [id, profilePath, profileName, character]);
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
