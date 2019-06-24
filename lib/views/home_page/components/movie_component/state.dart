import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

import '../../state.dart';

class MovieCellsState implements Cloneable<MovieCellsState> {
  VideoListModel movie=new VideoListModel.fromParams(results: List<VideoListResult>());
  @override
  MovieCellsState clone() {
    return MovieCellsState()
    ..movie=movie;
  }
}

MovieCellsState initMoviceCellsState(Map<String, dynamic> args) {
  return MovieCellsState();
}
class MovieCellsConnector
    extends ConnOp<HomePageState, MovieCellsState> {
  @override
  MovieCellsState get(HomePageState state) {
    MovieCellsState mstate = MovieCellsState();
    mstate.movie = state.movie;
    return mstate;
  }
}
