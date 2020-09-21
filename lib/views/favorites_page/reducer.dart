import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:palette_generator/palette_generator.dart';

import 'action.dart';
import 'state.dart';

Reducer<FavoritesPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<FavoritesPageState>>{
      FavoritesPageAction.action: _onAction,
      FavoritesPageAction.setBackground: _setBackground,
      FavoritesPageAction.updateColor: _updateColor,
      FavoritesPageAction.setMovie: _setMovie,
      FavoritesPageAction.setTVShow: _setTVShow
    },
  );
}

FavoritesPageState _onAction(FavoritesPageState state, Action action) {
  final FavoritesPageState newState = state.clone();
  return newState;
}

FavoritesPageState _setBackground(FavoritesPageState state, Action action) {
  final UserMedia result = action.payload;
  final FavoritesPageState newState = state.clone();
  if (state.selectedMedia != null) newState.selectedMedia = result;
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
  newState.movies = movie;
  if (movie.data.length > 0 &&
      newState.selectedMedia == null &&
      newState.isMovie) {
    newState.selectedMedia = movie.data[0];
  }
  return newState;
}

FavoritesPageState _setTVShow(FavoritesPageState state, Action action) {
  final UserMediaModel tv = action.payload;
  final FavoritesPageState newState = state.clone();
  newState.tvshows = tv;
  if (tv.data.length > 0 &&
      newState.selectedMedia == null &&
      !newState.isMovie) {
    newState.selectedMedia = tv.data[0];
  }
  return newState;
}
