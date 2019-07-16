import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PopularAction { action,cellTapped }

class PopularActionCreator {
  static Action onAction() {
    return const Action(PopularAction.action);
  }
  static Action onCellTapped(int id,String bgpic,String title,String posterpic) {
    return Action(PopularAction.cellTapped,payload:[id,bgpic,title,posterpic]);
  }
}
