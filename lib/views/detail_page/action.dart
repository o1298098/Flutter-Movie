import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/moviedetail.dart';

//TODO replace with your own action
enum MovieDetailPageAction {
  action,
  updateDetail,
  setImages,
  playTrailer,
  externalTapped,
  stillImageTapped,
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
}
