import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videomodel.dart';
import 'package:movie/views/tvdetail_page/state.dart';

class VideoState implements Cloneable<VideoState> {
  List<VideoResult> videos;
  @override
  VideoState clone() {
    return VideoState();
  }
}

class VideoConnector extends ConnOp<TVDetailPageState, VideoState> {
  @override
  VideoState get(TVDetailPageState state) {
    VideoState mstate = VideoState();
    mstate.videos = state.videomodel.results;
    return mstate;
  }
}
