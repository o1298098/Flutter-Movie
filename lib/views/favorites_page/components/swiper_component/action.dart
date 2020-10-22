import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_media.dart';

enum SwiperAction {
  action,
  mediaTpyeChanged,
  setBackground,
  cellTapped,
}

class SwiperActionCreator {
  static Action onAction() {
    return const Action(SwiperAction.action);
  }

  static Action mediaTpyeChanged(bool ismovie) {
    return Action(SwiperAction.mediaTpyeChanged, payload: ismovie);
  }

  static Action setBackground(UserMedia result) {
    return Action(SwiperAction.setBackground, payload: result);
  }

  static Action cellTapped(UserMedia media) {
    return Action(SwiperAction.cellTapped, payload: media);
  }
}
