import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum KeyWordsAction { action }

class KeyWordsActionCreator {
  static Action onAction() {
    return const Action(KeyWordsAction.action);
  }
}
