import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GalleryState> buildReducer() {
  return asReducer(
    <Object, Reducer<GalleryState>>{
      GalleryAction.action: _onAction,
    },
  );
}

GalleryState _onAction(GalleryState state, Action action) {
  final GalleryState newState = state.clone();
  return newState;
}
