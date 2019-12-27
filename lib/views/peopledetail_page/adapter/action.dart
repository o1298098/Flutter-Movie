import 'package:fish_redux/fish_redux.dart';

enum PeopleAction { action }

class PeopleActionCreator {
  static Action onAction() {
    return const Action(PeopleAction.action);
  }
}
