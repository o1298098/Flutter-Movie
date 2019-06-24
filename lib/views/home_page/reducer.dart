import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomePageState>>{
      HomePageAction.action: _onAction,
      HomePageAction.initMovie:_onInitMovie,
      HomePageAction.initTV:_onInitTV,
    },
  );
}

HomePageState _onAction(HomePageState state, Action action) {
  final HomePageState newState = state.clone();
  return newState;
}
HomePageState _onInitMovie(HomePageState state, Action action) {
  final VideoListModel model=action.payload??null;
  final HomePageState newState = state.clone();
  newState.movie=model;
  return newState;
}
HomePageState _onInitTV(HomePageState state, Action action) {
  final VideoListModel model=action.payload??null;
  final HomePageState newState = state.clone();
  newState.tv=model;
  return newState;
}
