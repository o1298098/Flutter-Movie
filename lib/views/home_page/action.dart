import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/moviechange.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum HomePageAction { action ,initMovie,initTV,initPopularMovies,initPopularTVShows,popularFilterChanged}

class HomePageActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }
  static Action onInitMovie(VideoListModel movie) {
    return Action(HomePageAction.initMovie,payload: movie);
  }
  static Action onInitTV(VideoListModel tv) {
    return Action(HomePageAction.initTV,payload: tv);
  }
  static Action onInitPopularMovie(VideoListModel pop) {
    return Action(HomePageAction.initPopularMovies,payload: pop);
  }
  static Action onInitPopularTV(VideoListModel pop) {
    return Action(HomePageAction.initPopularTVShows,payload: pop);
  }
  static Action onPopularFilterChanged(bool e) {
    return Action(HomePageAction.popularFilterChanged,payload: e);
  }
}
