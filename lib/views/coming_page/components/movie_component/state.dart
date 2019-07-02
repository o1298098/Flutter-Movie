import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/views/coming_page/state.dart';

class MovieListState implements Cloneable<MovieListState> {
  VideoListModel moviecoming;
  ScrollController movieController;
  @override
  MovieListState clone() {
    return MovieListState()
    ..moviecoming
    ..movieController;
  }
}

class MovieListConnector extends ConnOp<ComingPageState,MovieListState>{
  @override
  MovieListState get(ComingPageState state) {
    MovieListState substate=new MovieListState();
    substate.moviecoming=state.moviecoming;
    substate.movieController=state.movieController;
    return substate;
  }
}
