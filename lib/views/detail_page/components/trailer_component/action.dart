import 'package:fish_redux/fish_redux.dart';

enum TrailerAction {
  action,
  playTrailer,
}

class TrailerActionCreator {
  static Action onAction() {
    return const Action(TrailerAction.action);
  }

  static Action playTrailer(String videoKey) {
    return Action(TrailerAction.playTrailer, payload: videoKey);
  }
}
