import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_media.dart';

import 'action.dart';
import 'state.dart';

Reducer<SwiperState> buildReducer() {
  return asReducer(
    <Object, Reducer<SwiperState>>{
      SwiperAction.action: _onAction,
      SwiperAction.mediaTpyeChanged: _mediaTpyeChanged,
      SwiperAction.setBackground: _setBackground,
    },
  );
}

SwiperState _onAction(SwiperState state, Action action) {
  final SwiperState newState = state.clone();
  return newState;
}

SwiperState _mediaTpyeChanged(SwiperState state, Action action) {
  final bool r = action.payload;
  final SwiperState newState = state.clone();
  newState.isMovie = r;
  newState.selectedMedia = r ? state.movies?.data[0] : state.tvshows?.data[0];
  return newState;
}

SwiperState _setBackground(SwiperState state, Action action) {
  final UserMedia result = action.payload;
  final SwiperState newState = state.clone();
  if (state.selectedMedia != null) newState.selectedMedia = result;
  return newState;
}
