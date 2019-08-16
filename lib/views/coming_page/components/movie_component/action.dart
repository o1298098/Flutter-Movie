import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MovieListAction { action, cellTapped }

class MovieListActionCreator {
  static Action onAction() {
    return const Action(MovieListAction.action);
  }

  static Action cellTapped(int id) {
    return Action(MovieListAction.cellTapped, payload: id);
  }
}
