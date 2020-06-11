import 'package:fish_redux/fish_redux.dart';

enum MenuAction {
  action,
  setRating,
  updateRating,
  setFavorite,
  updateFavorite,
  setWatchlist,
  updateWatchlist
}

class MenuActionCreator {
  static Action onAction() {
    return const Action(MenuAction.action);
  }

  static Action setRating(double d) {
    return Action(MenuAction.setRating, payload: d);
  }

  static Action updateRating(double d) {
    return Action(MenuAction.updateRating, payload: d);
  }

  static Action setFavorite(bool isFavorite) {
    return Action(MenuAction.setFavorite, payload: isFavorite);
  }

  static Action updateFavorite(bool isFavorite) {
    return Action(MenuAction.updateFavorite, payload: isFavorite);
  }

  static Action setWatchlist(bool isAdd) {
    return Action(MenuAction.setWatchlist, payload: isAdd);
  }

  static Action updateWatctlist(bool isAdd) {
    return Action(MenuAction.updateWatchlist, payload: isAdd);
  }
}
