import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ImagesState> buildReducer() {
  return asReducer(
    <Object, Reducer<ImagesState>>{
      ImagesAction.action: _onAction,
    },
  );
}

ImagesState _onAction(ImagesState state, Action action) {
  final ImagesState newState = state.clone();
  return newState;
}
