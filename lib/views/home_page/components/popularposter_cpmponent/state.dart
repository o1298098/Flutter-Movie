import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

import '../../state.dart';

class PopularPosterState implements Cloneable<PopularPosterState> {
  VideoListModel popularMoives;
  VideoListModel popularTVShows;
  bool showmovie;
  @override
  PopularPosterState clone() {
    return PopularPosterState()
      ..popularMoives = popularMoives
      ..popularTVShows = popularTVShows
      ..showmovie = showmovie;
  }
}

class PopularPosterConnector extends ConnOp<HomePageState, PopularPosterState> {
  @override
  PopularPosterState get(HomePageState state) {
    PopularPosterState mstate = PopularPosterState();
    mstate.popularMoives = state.popularMovies;
    mstate.popularTVShows = state.popularTVShows;
    mstate.showmovie = state.showPopMovie;
    return mstate;
  }

  @override
  void set(HomePageState state, PopularPosterState subState) {
    state.showPopMovie = subState.showmovie;
  }
}
