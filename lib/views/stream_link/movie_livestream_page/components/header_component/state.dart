import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/views/stream_link/movie_livestream_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  String name;
  String background;
  String overview;
  MovieDetailModel detail;
  @override
  HeaderState clone() {
    return HeaderState()
      ..name = name
      ..background = background
      ..overview = overview
      ..detail = detail;
  }
}

class HeaderConnector extends ConnOp<MovieLiveStreamState, HeaderState> {
  @override
  HeaderState get(MovieLiveStreamState state) {
    HeaderState mstate = HeaderState();
    mstate.detail = state.detail;
    mstate.background = state.background;
    mstate.name = state.name;
    mstate.overview = state.overview;
    return mstate;
  }
}
