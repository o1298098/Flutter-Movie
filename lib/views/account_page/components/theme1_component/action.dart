import 'package:fish_redux/fish_redux.dart';

enum Theme1Action { action }

class Theme1ActionCreator {
  static Action onAction() {
    return const Action(Theme1Action.action);
  }
}
