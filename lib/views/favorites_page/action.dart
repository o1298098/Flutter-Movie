import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/painting.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/videolist.dart';
import 'package:palette_generator/palette_generator.dart';

//TODO replace with your own action
enum FavoritesPageAction {
  action,
  mediaTpyeChanged,
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

  static Action mediaTpyeChanged(bool ismovie) {
    return Action(FavoritesPageAction.mediaTpyeChanged, payload: ismovie);
  }

  static Action setFavoriteMovies(VideoListModel d) {
    return Action(FavoritesPageAction.setFavoriteMovies, payload: d);
  }

  static Action setFavoriteTV(VideoListModel d) {
    return Action(FavoritesPageAction.setFavoriteTV, payload: d);
  }

  static Action setBackground(UserMedia result, Color color) {
    return Action(FavoritesPageAction.setBackground, payload: [result, color]);
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
