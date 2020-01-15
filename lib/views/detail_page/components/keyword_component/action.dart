import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum KeyWordAction { action }

class KeyWordActionCreator {
  static Action onAction() {
    return const Action(KeyWordAction.action);
  }
}
