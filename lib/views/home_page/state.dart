import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/movielist.dart';
import 'package:movie/models/tvlist.dart';

class HomePageState implements Cloneable<HomePageState> {

MoiveListModel movie=new MoiveListModel.fromParams(results: List<MovieListResult>());
TVListModel tv=new TVListModel.fromParams(results:List<TVListResult>());

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
