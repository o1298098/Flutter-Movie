import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/video_model.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class SwiperState implements Cloneable<SwiperState> {
  List<VideoResult> videos;
  List<ImageData> backdrops;
  @override
  SwiperState clone() {
    return SwiperState();
  }
}

class SwiperConnector extends ConnOp<TvShowDetailState, SwiperState> {
  @override
  SwiperState get(TvShowDetailState state) {
    SwiperState substate = new SwiperState();
    substate.backdrops = state.imagesmodel?.backdrops;
    substate.videos = state.videomodel?.results;
    return substate;
  }
}
