import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/videolist.dart';
import 'package:palette_generator/palette_generator.dart';

import 'action.dart';
import 'state.dart';

Reducer<FavoritesPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<FavoritesPageState>>{
      FavoritesPageAction.action: _onAction,
      FavoritesPageAction.setFavoriteMovies:_setFavoriteMovies,
      FavoritesPageAction.setFavoriteTV:_setFavoriteTV,
      FavoritesPageAction.setBackground:_setBackground,
      FavoritesPageAction.updateColor:_updateColor,
      FavoritesPageAction.mediaTpyeChanged:_mediaTpyeChanged,
    },
  );
}

FavoritesPageState _onAction(FavoritesPageState state, Action action) {
  final FavoritesPageState newState = state.clone();
  return newState;
}
FavoritesPageState _setFavoriteMovies(FavoritesPageState state, Action action) {
  final VideoListModel model=action.payload;
  final FavoritesPageState newState = state.clone();
  newState.favoriteMovies=model;
  newState.backgroundColor=Colors.cyan.withAlpha(80);
  newState.secbackgroundUrl=model.results[0].poster_path;
  newState.selectedMedia=model.results[0];
  return newState;
}
FavoritesPageState _setFavoriteTV(FavoritesPageState state, Action action) {
  final VideoListModel model=action.payload;
  final FavoritesPageState newState = state.clone();
  newState.favoriteTVShows=model;
  return newState;
}

FavoritesPageState _mediaTpyeChanged(FavoritesPageState state, Action action) {
  final bool r=action.payload;
  final FavoritesPageState newState = state.clone();
  newState.isMovie=r;
  newState.selectedMedia=r?state.favoriteMovies.results[0]:state.favoriteTVShows.results[0];
  return newState;
}

FavoritesPageState _setBackground(FavoritesPageState state, Action action) {
  final VideoListResult result=action.payload[0];
  final Color color=action.payload[01];
  final FavoritesPageState newState = state.clone();
  newState.secbackgroundUrl=state.selectedMedia.poster_path;
  newState.selectedMedia=result;
  newState.backgroundColor=color;
  return newState;
}

FavoritesPageState _updateColor(FavoritesPageState state, Action action) {
  final PaletteGenerator palette=action.payload;
  final FavoritesPageState newState = state.clone();
  newState.paletteGenerator=palette;
  return newState;
}
