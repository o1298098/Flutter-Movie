import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MenuState> buildReducer() {
  return asReducer(
    <Object, Reducer<MenuState>>{
      MenuAction.action: _onAction,
      MenuAction.updateRating: _updateRating,
      MenuAction.updateFavorite: _updateFavorite,
      MenuAction.updateWatchlist: _updateWatchlist
    },
  );
}

MenuState _onAction(MenuState state, Action action) {
  final MenuState newState = state.clone();
  return newState;
}

MenuState _updateRating(MenuState state, Action action) {
  final MenuState newState = state.clone();
  newState.accountState.rated = action.payload;
  return newState;
}

MenuState _updateFavorite(MenuState state, Action action) {
  final bool favorite = action.payload;
  final MenuState newState = state.clone();
  newState.accountState.favorite = favorite;
  return newState;
}

MenuState _updateWatchlist(MenuState state, Action action) {
  final bool isAdd = action.payload;
  final MenuState newState = state.clone();
  newState.accountState.watchlist = isAdd;
  return newState;
}
