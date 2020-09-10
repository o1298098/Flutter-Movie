import 'package:fish_redux/fish_redux.dart';

enum TestAction { action }

class TestActionCreator {
  static Action onAction(int value) {
    return Action(TestAction.action, payload: value);
  }
}
