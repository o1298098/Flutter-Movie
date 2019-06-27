import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HeaderAction { action }

class HeaderActionCreator {
  static Action onAction() {
    return const Action(HeaderAction.action);
  }
}
