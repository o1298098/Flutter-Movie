import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/views/home_page/state.dart';

class SwiperState implements Cloneable<SwiperState> {
  VideoListModel movie;
  VideoListModel tv;
  bool showHeaderMovie;
  @override
  SwiperState clone() {
    return SwiperState();
  }
}

class SwiperConnector extends ConnOp<HomePageState, SwiperState> {
  @override
  SwiperState get(HomePageState state) {
    SwiperState mstate = SwiperState();
    mstate.movie = state.movie;
    mstate.tv = state.tv;
    mstate.showHeaderMovie = state.showHeaderMovie;
    return mstate;
  }
}
