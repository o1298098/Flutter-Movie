import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/views/watchlist_page/state.dart';

class SwiperState implements Cloneable<SwiperState> {
  bool isMovie;
  SwiperController swiperController;
  UserMediaModel movies;
  UserMediaModel tvshows;
  @override
  SwiperState clone() {
    return SwiperState();
  }
}

class SwiperConnector extends ConnOp<WatchlistPageState, SwiperState> {
  @override
  SwiperState get(WatchlistPageState state) {
    final SwiperState mstate = SwiperState();
    mstate.isMovie = state.isMovie;
    mstate.movies = state.movies;
    mstate.tvshows = state.tvshows;
    return mstate;
  }

  @override
  void set(WatchlistPageState state, SwiperState subState) {
    state.isMovie = subState.isMovie;
  }
}
