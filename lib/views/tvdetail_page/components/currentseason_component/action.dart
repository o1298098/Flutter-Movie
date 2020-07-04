import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/seasondetail.dart';

enum CurrentSeasonAction { action, cellTapped, allSeasonsTapped }

class CurrentSeasonActionCreator {
  static Action onAction() {
    return const Action(CurrentSeasonAction.action);
  }

  static Action onCellTapped(
      int tvid, int seasonnum, String name, String posterpic) {
    return Action(CurrentSeasonAction.cellTapped,
        payload: [tvid, seasonnum, name, posterpic]);
  }

  static Action onAllSeasonsTapped(int tvid, List<Season> list) {
    return Action(CurrentSeasonAction.allSeasonsTapped, payload: [tvid, list]);
  }
}
