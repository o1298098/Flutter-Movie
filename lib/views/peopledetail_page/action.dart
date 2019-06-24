import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PeopleDetailPageAction { action }

class PeopleDetailPageActionCreator {
  static Action onAction() {
    return const Action(PeopleDetailPageAction.action);
  }
}
