import 'package:fish_redux/fish_redux.dart';

enum KeyWordAction { action }

class KeyWordActionCreator {
  static Action onAction() {
    return const Action(KeyWordAction.action);
  }
}
