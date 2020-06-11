import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';

enum SeasonAction { action, cellTapped }

class SeasonActionCreator {
  static Action onAction() {
    return const Action(SeasonAction.action);
  }

  static Action cellTapped(Season season) {
    return Action(SeasonAction.cellTapped, payload: season);
  }
}
