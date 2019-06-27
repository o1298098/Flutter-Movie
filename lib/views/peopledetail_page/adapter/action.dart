import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PeopleAction { action }

class PeopleActionCreator {
  static Action onAction() {
    return const Action(PeopleAction.action);
  }
}
