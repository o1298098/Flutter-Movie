import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CurrentSeasonAction { action ,cellTapped}

class CurrentSeasonActionCreator {
  static Action onAction() {
    return const Action(CurrentSeasonAction.action);
  }
  static Action onCellTapped(int tvid,int seasonnum,String name,String posterpic) {
    return Action(CurrentSeasonAction.cellTapped,payload: [tvid,seasonnum,name,posterpic]);
  }
}
