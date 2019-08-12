import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PopularPosterAction { action, cellTapped }

class PopularPosterActionCreator {
  static Action onAction() {
    return const Action(PopularPosterAction.action);
  }

  static Action onCellTapped(
      int id, String bgpic, String title, String posterpic) {
    return Action(PopularPosterAction.cellTapped,
        payload: [id, bgpic, title, posterpic]);
  }
}
