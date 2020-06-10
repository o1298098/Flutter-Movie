import 'package:fish_redux/fish_redux.dart';

enum KeywordAction { action }

class KeywordActionCreator {
  static Action onAction() {
    return const Action(KeywordAction.action);
  }
}
