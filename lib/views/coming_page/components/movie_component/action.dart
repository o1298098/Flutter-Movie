import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MovieListAction { action }

class MovieListActionCreator {
  static Action onAction() {
    return const Action(MovieListAction.action);
  }
}
