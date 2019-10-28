import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/enums/media_type.dart';

//TODO replace with your own action
enum MenuAction {
  action,
  setRating,
  updateRating,
  setFavorite,
  updateFavorite,
  setWatchlist,
  updateWatchlist,
  setFirebaseFavorite,
  addStreamLink,
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

  static Action setFirebaseFavorite() {
    return Action(MenuAction.setFirebaseFavorite);
  }

  static Action addStreamLink(
      int id, String name, String poster, MediaType type) {
    return Action(MenuAction.addStreamLink, payload: [id, name, poster, type]);
  }
}
