import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum StartPageAction { action, setIsFirst, onStart }

class StartPageActionCreator {
  static Action onAction() {
    return const Action(StartPageAction.action);
  }

  static Action onStart() {
    return const Action(StartPageAction.onStart);
  }

  static Action setIsFirst(bool isFirst) {
    return Action(StartPageAction.setIsFirst, payload: isFirst);
  }
}
