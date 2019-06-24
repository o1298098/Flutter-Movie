import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MovieCellAction { action,
  movieCellTapped, }

class MovieCellActionCreator {
  static Action onAction() {
    return const Action(MovieCellAction.action);
  }
   static Action onMovieCellTapped(int movieid) {
    return Action(MovieCellAction.movieCellTapped,payload: movieid);
  }
}
