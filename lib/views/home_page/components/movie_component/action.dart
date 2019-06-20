import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MovieCellsAction { action,celltapped }

class MovieCellsActionCreator {
  static Action onAction() {
    return const Action(MovieCellsAction.action);
  }
  static Action onCellTapped(int movieid){
    return Action(MovieCellsAction.celltapped,payload: movieid);
  }
}
