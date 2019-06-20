import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/moviechange.dart';
import 'package:movie/models/movielist.dart';
import 'package:movie/models/tvlist.dart';

//TODO replace with your own action
enum HomePageAction { action ,initMovie,initTV}

class HomePageActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }
  static Action onInitMovie(MoiveListModel movie) {
    return Action(HomePageAction.initMovie,payload: movie);
  }
  static Action onInitTV(TVListModel tv) {
    return Action(HomePageAction.initTV,payload: tv);
  }
}
