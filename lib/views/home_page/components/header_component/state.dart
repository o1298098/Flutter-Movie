import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/views/home_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  VideoListModel movie;
  VideoListModel tv;
  bool showHeaderMovie;
  @override
  HeaderState clone() {
    return HeaderState()
      ..movie = movie
      ..tv = tv
      ..showHeaderMovie = showHeaderMovie;
  }
}

class HeaderConnector extends ConnOp<HomePageState, HeaderState> {
  @override
  HeaderState get(HomePageState state) {
    HeaderState mstate = HeaderState();
    mstate.movie = state.movie;
    mstate.tv = state.tv;
    mstate.showHeaderMovie = state.showHeaderMovie;
    return mstate;
  }

  @override
  void set(HomePageState state, HeaderState subState) {
    state.showHeaderMovie = subState.showHeaderMovie;
  }
}
