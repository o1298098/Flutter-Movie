import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CastAction { action, cellTapped }

class CastActionCreator {
  static Action onAction() {
    return const Action(CastAction.action);
  }

  static Action onCellTapped(
      int id, String profilePath, String profileName, String character) {
    return Action(CastAction.cellTapped,
        payload: [id, profilePath, profileName, character]);
  }
}
