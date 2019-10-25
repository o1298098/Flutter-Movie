import 'package:cloud_firestore/cloud_firestore.dart';
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
      FavoritesPageAction.setBackground: _setBackground,
      FavoritesPageAction.updateColor: _updateColor,
      FavoritesPageAction.mediaTpyeChanged: _mediaTpyeChanged,
      FavoritesPageAction.setMovieSnapshot: _setMovieSnapshot,
      FavoritesPageAction.setTVShowSnapshot: _setTVShowSnapshot
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
  newState.selectedMedia =
      r ? state.movieSnapshot?.documents[0] : state.tvSnapshot?.documents[0];
  return newState;
}

FavoritesPageState _setBackground(FavoritesPageState state, Action action) {
  final DocumentSnapshot result = action.payload[0];
  final Color color = action.payload[01];
  final FavoritesPageState newState = state.clone();
  if (state.selectedMedia != null)
    newState.secbackgroundUrl = state.selectedMedia['photourl'];
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

FavoritesPageState _setMovieSnapshot(FavoritesPageState state, Action action) {
  final QuerySnapshot movieSnapshot = action.payload;
  final FavoritesPageState newState = state.clone();
  newState.backgroundColor = Colors.cyan.withAlpha(80);
  newState.movieSnapshot = movieSnapshot;
  if (movieSnapshot.documents.length > 0) {
    newState.selectedMedia = movieSnapshot.documents[0];
    newState.secbackgroundUrl = newState.selectedMedia['photourl'];
  }
  return newState;
}

FavoritesPageState _setTVShowSnapshot(FavoritesPageState state, Action action) {
  final QuerySnapshot tvSnapshot = action.payload;
  final FavoritesPageState newState = state.clone();
  newState.tvSnapshot = tvSnapshot;
  return newState;
}
