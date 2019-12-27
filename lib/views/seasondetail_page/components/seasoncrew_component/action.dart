import 'package:fish_redux/fish_redux.dart';

enum SeasonCrewAction { action }

class SeasonCrewActionCreator {
  static Action onAction() {
    return const Action(SeasonCrewAction.action);
  }
}
