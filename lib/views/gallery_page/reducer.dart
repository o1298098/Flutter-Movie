import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GalleryPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<GalleryPageState>>{
      GalleryPageAction.action: _onAction,
    },
  );
}

GalleryPageState _onAction(GalleryPageState state, Action action) {
  final GalleryPageState newState = state.clone();
  return newState;
}
