import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/videolist.dart';
import 'package:palette_generator/palette_generator.dart';

import 'action.dart';
import 'state.dart';

Reducer<FavoritesPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<FavoritesPageState>>{
      FavoritesPageAction.action: _onAction,
      FavoritesPageAction.setBackground: _setBackground,
      FavoritesPageAction.updateColor: _updateColor,
      FavoritesPageAction.mediaTpyeChanged: _mediaTpyeChanged,
      FavoritesPageAction.setMovie: _setMovie,
      FavoritesPageAction.setTVShow: _setTVShow
    },
  );
}

FavoritesPageState _onAction(FavoritesPageState state, Action action) {
  final FavoritesPageState newState = state.clone();
  return newState;
}

FavoritesPageState _mediaTpyeChanged(FavoritesPageState state, Action action) {
  final bool r = action.payload;
  final FavoritesPageState newState = state.clone();
  newState.isMovie = r;
  newState.selectedMedia = r ? state.movies?.data[0] : state.tvshows?.data[0];
  return newState;
}

FavoritesPageState _setBackground(FavoritesPageState state, Action action) {
  final UserMedia result = action.payload[0];
  final Color color = action.payload[01];
  final FavoritesPageState newState = state.clone();
  if (state.selectedMedia != null)
    newState.secbackgroundUrl = state.selectedMedia.photoUrl;
  newState.selectedMedia = result;
  newState.backgroundColor = color;
  return newState;
}

FavoritesPageState _updateColor(FavoritesPageState state, Action action) {
  final PaletteGenerator palette = action.payload;
  final FavoritesPageState newState = state.clone();
  newState.paletteGenerator = palette;
  return newState;
}

FavoritesPageState _setMovie(FavoritesPageState state, Action action) {
  final UserMediaModel movie = action.payload;
  final FavoritesPageState newState = state.clone();
  newState.backgroundColor = Colors.cyan.withAlpha(80);
  newState.movies = movie;
  if (movie.data.length > 0) {
    newState.selectedMedia = movie.data[0];
    newState.secbackgroundUrl = newState.selectedMedia.photoUrl;
  }
  return newState;
}

FavoritesPageState _setTVShow(FavoritesPageState state, Action action) {
  final UserMediaModel tv = action.payload;
  final FavoritesPageState newState = state.clone();
  newState.tvshows = tv;
  return newState;
}
