import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

class VideoCellState implements Cloneable<VideoCellState> {

  VideoListResult videodata;
 
  @override
  VideoCellState clone() {
    return VideoCellState()..videodata=videodata;
  }
}

VideoCellState initState(Map<String, dynamic> args) {
  return VideoCellState();
}
