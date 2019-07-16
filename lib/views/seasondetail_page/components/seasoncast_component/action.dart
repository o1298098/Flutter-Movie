import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SeasonCastAction { action,buttonClicked
  ,castCellTapped, }

class SeasonCastActionCreator {
  static Action onAction() {
    return const Action(SeasonCastAction.action);
  }
  static Action onButtonClicked() {
    return const Action(SeasonCastAction.buttonClicked);
  }
  static Action onCastCellTapped(int peopleid,String profilePath,String profileName) {
    return Action(SeasonCastAction.castCellTapped, payload:[peopleid,profilePath,profileName]);
  }
}
