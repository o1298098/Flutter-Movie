import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/video_list.dart';
import 'package:palette_generator/palette_generator.dart';

enum FavoritesPageAction {
  action,
  setFavoriteMovies,
  setFavoriteTV,
  setBackground,
  setColor,
  updateColor,
  setMovie,
  setTVShow,
}

class FavoritesPageActionCreator {
  static Action onAction() {
    return const Action(FavoritesPageAction.action);
  }

  static Action setFavoriteMovies(VideoListModel d) {
    return Action(FavoritesPageAction.setFavoriteMovies, payload: d);
  }

  static Action setFavoriteTV(VideoListModel d) {
    return Action(FavoritesPageAction.setFavoriteTV, payload: d);
  }

  static Action setBackground(UserMedia result) {
    return Action(FavoritesPageAction.setBackground, payload: result);
  }

  static Action setColor(String url) {
    return Action(FavoritesPageAction.setColor, payload: url);
  }

  static Action updateColor(PaletteGenerator palette) {
    return Action(FavoritesPageAction.updateColor, payload: palette);
  }

  static Action setMovie(UserMediaModel d) {
    return Action(FavoritesPageAction.setMovie, payload: d);
  }

  static Action setTVShow(UserMediaModel d) {
    return Action(FavoritesPageAction.setTVShow, payload: d);
  }
}
