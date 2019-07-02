import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MovieCellsAction { action,celltapped }

class MovieCellsActionCreator {
  static Action onAction() {
    return const Action(MovieCellsAction.action);
  }
  static Action onCellTapped(int movieid,String bgpic,String title,String postpic){
    return Action(MovieCellsAction.celltapped,payload: [movieid,bgpic,title,postpic]);
  }
}
