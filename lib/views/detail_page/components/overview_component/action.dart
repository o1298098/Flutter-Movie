import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OverViewAction { action }

class OverViewActionCreator {
  static Action onAction() {
    return const Action(OverViewAction.action);
  }
}
