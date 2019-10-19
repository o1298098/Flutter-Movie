import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum Theme3Action { action, testTapped }

class Theme3ActionCreator {
  static Action onAction() {
    return const Action(Theme3Action.action);
  }

  static Action onTestTapped() {
    return const Action(Theme3Action.testTapped);
  }
}
