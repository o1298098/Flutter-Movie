import 'package:fish_redux/fish_redux.dart';

enum OverViewAction { action }

class OverViewActionCreator {
  static Action onAction() {
    return const Action(OverViewAction.action);
  }
}
