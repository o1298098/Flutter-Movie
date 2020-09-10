import 'package:fish_redux/fish_redux.dart';

enum KeyWordsAction { action }

class KeyWordsActionCreator {
  static Action onAction() {
    return const Action(KeyWordsAction.action);
  }
}
