import 'package:fish_redux/fish_redux.dart';

enum SeasonCastAction {
  action,
  buttonClicked,
  castCellTapped,
}

class SeasonCastActionCreator {
  static Action onAction() {
    return const Action(SeasonCastAction.action);
  }

  static Action onButtonClicked() {
    return const Action(SeasonCastAction.buttonClicked);
  }

  static Action onCastCellTapped(
      int peopleid, String profilePath, String profileName) {
    return Action(SeasonCastAction.castCellTapped,
        payload: [peopleid, profilePath, profileName]);
  }
}
