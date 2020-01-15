import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum StillAction { action }

class StillActionCreator {
  static Action onAction() {
    return const Action(StillAction.action);
  }
}
