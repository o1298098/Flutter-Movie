import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TVCellsAction { action ,celltapped}

class TVCellsActionCreator {
  static Action onAction() {
    return const Action(TVCellsAction.action);
  }
  static Action onCellTapped(int tvid,String bgpic,String name,String posterpic){
    return Action(TVCellsAction.celltapped,payload: [tvid,bgpic,name,posterpic]);
  }
}
