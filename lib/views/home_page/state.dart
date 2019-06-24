import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

class HomePageState implements Cloneable<HomePageState> {

VideoListModel movie=new VideoListModel.fromParams(results: List<VideoListResult>());
VideoListModel tv=new VideoListModel.fromParams(results:List<VideoListResult>());

  @override
  HomePageState clone() {
    return HomePageState()
    ..tv=tv
    ..movie=movie;
  }
}
HomePageState initState(Map<String, dynamic> args) {
  var state=HomePageState();
  return state;
}
