import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

class VideoCellState implements Cloneable<VideoCellState> {
  VideoListResult videodata;
  bool isMovie;

  @override
  VideoCellState clone() {
    return VideoCellState()
      ..videodata = videodata
      ..isMovie = isMovie;
  }
}

VideoCellState initState(Map<String, dynamic> args) {
  return VideoCellState();
}
