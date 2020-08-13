import 'package:fish_redux/fish_redux.dart';

enum PlayerAction { action }

class PlayerActionCreator {
  static Action onAction() {
    return const Action(PlayerAction.action);
  }
}
