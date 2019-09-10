import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum Theme2Action { action }

class Theme2ActionCreator {
  static Action onAction() {
    return const Action(Theme2Action.action);
  }
}
