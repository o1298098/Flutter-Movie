import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/movielist.dart';

import '../../state.dart';

class MovieCellsState implements Cloneable<MovieCellsState> {
  MoiveListModel movie=new MoiveListModel.fromParams(results: List<MovieListResult>());
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
