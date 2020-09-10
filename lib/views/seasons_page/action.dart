import 'package:fish_redux/fish_redux.dart';

enum SeasonsPageAction { action, cellTapped }

class SeasonsPageActionCreator {
  static Action onAction() {
    return const Action(SeasonsPageAction.action);
  }

  static Action onCellTapped(
      int tvid, int seasonnum, String name, String posterpic) {
    return Action(SeasonsPageAction.cellTapped,
        payload: [tvid, seasonnum, name, posterpic]);
  }
}
