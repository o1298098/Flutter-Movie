import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SeasonCrewAction { action }

class SeasonCrewActionCreator {
  static Action onAction() {
    return const Action(SeasonCrewAction.action);
  }
}
