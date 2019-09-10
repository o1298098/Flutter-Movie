import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum Theme1Action { action }

class Theme1ActionCreator {
  static Action onAction() {
    return const Action(Theme1Action.action);
  }
}
