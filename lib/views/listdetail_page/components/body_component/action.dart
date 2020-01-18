import 'package:fish_redux/fish_redux.dart';

enum BodyAction { action }

class BodyActionCreator {
  static Action onAction() {
    return const Action(BodyAction.action);
  }
}
