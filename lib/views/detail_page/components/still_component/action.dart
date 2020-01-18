import 'package:fish_redux/fish_redux.dart';

enum StillAction { action }

class StillActionCreator {
  static Action onAction() {
    return const Action(StillAction.action);
  }
}
