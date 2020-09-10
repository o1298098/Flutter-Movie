import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_model.dart';
import 'package:movie/views/detail_page/state.dart';

class TrailerState implements Cloneable<TrailerState> {
  VideoModel videos;
  @override
  TrailerState clone() {
    return TrailerState()..videos = videos;
  }
}

class TrailerConnector extends ConnOp<MovieDetailPageState, TrailerState> {
  @override
  TrailerState get(MovieDetailPageState state) {
    TrailerState substate = new TrailerState();
    substate.videos = state.detail?.videos;
    return substate;
  }
}
